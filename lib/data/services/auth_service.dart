import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sxe/data/models/user_model.dart';

class AuthService {
  static const String _userKey = 'user_data';
  static const String _sessionKey = 'session_data';

  final Client _client;
  late final Account _account;

  UserModel? _currentUser;
  String? _currentSession;

  AuthService(this._client) {
    _account = Account(_client);
  }

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null && _currentSession != null;
  String? get currentSession => _currentSession;

  /// Initialize the auth service and check for existing session
  Future<bool> initialize() async {
    try {
      await _loadStoredSession();

      if (_currentSession != null) {
        // Verify the session is still valid
        print('Checking existing session...');
        final user = await _account.get();
        _currentUser = UserModel.fromAppwriteUser(user);
        await _saveUserData();

        // Start session monitoring
        _startSessionMonitoring();
        print('Session valid, user authenticated');
        return true;
      }
      print('No existing session found');
      return false;
    } catch (e) {
      // Session is invalid, clear stored data
      print('Session validation failed: $e');
      await _clearStoredData();
      return false;
    }
  }

  /// Start monitoring session validity
  void _startSessionMonitoring() {
    // Check session every 5 minutes
    Stream.periodic(const Duration(minutes: 5)).listen((_) async {
      if (_currentSession != null) {
        try {
          await _account.get();
        } catch (e) {
          // Session expired, logout
          await logout();
        }
      }
    });
  }

  /// Register a new user
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      // Auto-login after registration
      await login(email: email, password: password);

      return UserModel.fromAppwriteUser(user);
    } on AppwriteException catch (e) {
      throw _handleAppwriteException(e);
    } catch (e) {
      throw AuthException('Registration failed: ${e.toString()}');
    }
  }

  /// Login with email and password
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting login for: $email');

      // Clear any existing sessions first to prevent 401 error
      try {
        await _account.deleteSessions();
        print('Cleared existing sessions');
      } catch (e) {
        print('No existing sessions to clear or error clearing: $e');
      }

      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      _currentSession = session.$id;
      await _saveSessionData();

      final user = await _account.get();
      _currentUser = UserModel.fromAppwriteUser(user);
      await _saveUserData();

      // Start session monitoring
      _startSessionMonitoring();

      print('Login successful for: ${_currentUser!.name}');
      return _currentUser!;
    } on AppwriteException catch (e) {
      print('Appwrite login error: ${e.code} - ${e.message}');
      throw _handleAppwriteException(e);
    } catch (e) {
      print('General login error: $e');
      throw AuthException('Login failed: ${e.toString()}');
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    try {
      if (_currentSession != null) {
        await _account.deleteSession(sessionId: _currentSession!);
      }
    } catch (e) {
      // Continue with logout even if session deletion fails
    } finally {
      _currentUser = null;
      _currentSession = null;
      await _clearStoredData();
    }
  }

  /// Send password recovery email
  Future<void> sendPasswordRecovery({required String email}) async {
    try {
      await _account.createRecovery(
        email: email,
        url:
            'https://your-app.com/reset-password', // Replace with your app's reset URL
      );
    } on AppwriteException catch (e) {
      throw _handleAppwriteException(e);
    } catch (e) {
      throw AuthException('Password recovery failed: ${e.toString()}');
    }
  }

  /// Update user password
  Future<void> updatePassword({
    required String newPassword,
    String? oldPassword,
  }) async {
    try {
      await _account.updatePassword(
        password: newPassword,
        oldPassword: oldPassword,
      );
    } on AppwriteException catch (e) {
      throw _handleAppwriteException(e);
    } catch (e) {
      throw AuthException('Password update failed: ${e.toString()}');
    }
  }

  /// Update user profile
  Future<UserModel> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      if (name != null) {
        await _account.updateName(name: name);
      }
      if (email != null) {
        await _account.updateEmail(
            email: email, password: ''); // Password required for email update
      }

      final user = await _account.get();
      _currentUser = UserModel.fromAppwriteUser(user);
      await _saveUserData();

      return _currentUser!;
    } on AppwriteException catch (e) {
      throw _handleAppwriteException(e);
    } catch (e) {
      throw AuthException('Profile update failed: ${e.toString()}');
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _account.createVerification(
        url:
            'https://your-app.com/verify-email', // Replace with your app's verification URL
      );
    } on AppwriteException catch (e) {
      throw _handleAppwriteException(e);
    } catch (e) {
      throw AuthException('Email verification failed: ${e.toString()}');
    }
  }

  /// Refresh current session
  Future<bool> refreshSession() async {
    try {
      if (_currentSession == null) return false;

      final user = await _account.get();
      _currentUser = UserModel.fromAppwriteUser(user);
      await _saveUserData();
      return true;
    } catch (e) {
      // Session is invalid
      await logout();
      return false;
    }
  }

  // Private methods
  Future<void> _saveUserData() async {
    if (_currentUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(_currentUser!.toJson()));
    }
  }

  Future<void> _saveSessionData() async {
    if (_currentSession != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_sessionKey, _currentSession!);
    }
  }

  Future<void> _loadStoredSession() async {
    final prefs = await SharedPreferences.getInstance();
    _currentSession = prefs.getString(_sessionKey);

    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _currentUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  Future<void> _clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_sessionKey);
  }

  AuthException _handleAppwriteException(AppwriteException e) {
    switch (e.code) {
      case 401:
        return AuthException('Invalid credentials');
      case 409:
        return AuthException('User already exists');
      case 429:
        return AuthException('Too many requests. Please try again later');
      case 404:
        return AuthException('Service not found. Please check your connection');
      case 500:
        return AuthException('Server error. Please try again later');
      default:
        return AuthException(e.message ?? 'Authentication error: ${e.code}');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
