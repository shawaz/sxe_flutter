import 'package:flutter/foundation.dart';
import 'package:sxe/data/models/user_model.dart';
import 'package:sxe/data/services/auth_service.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  
  AuthState _state = AuthState.initial;
  UserModel? _user;
  String? _errorMessage;
  bool _isLoading = false;

  AuthProvider(this._authService);

  // Getters
  AuthState get state => _state;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _state == AuthState.authenticated && _user != null;

  /// Initialize the auth provider
  Future<void> initialize() async {
    _setState(AuthState.loading);
    
    try {
      final hasValidSession = await _authService.initialize();
      
      if (hasValidSession) {
        _user = _authService.currentUser;
        _setState(AuthState.authenticated);
      } else {
        _setState(AuthState.unauthenticated);
      }
    } catch (e) {
      _setError('Initialization failed: ${e.toString()}');
    }
  }

  /// Register a new user
  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    _setLoading(true);
    
    try {
      _user = await _authService.register(
        email: email,
        password: password,
        name: name,
      );
      _setState(AuthState.authenticated);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Login with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    
    try {
      _user = await _authService.login(
        email: email,
        password: password,
      );
      _setState(AuthState.authenticated);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    _setLoading(true);
    
    try {
      await _authService.logout();
      _user = null;
      _setState(AuthState.unauthenticated);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Send password recovery email
  Future<bool> sendPasswordRecovery({required String email}) async {
    _setLoading(true);
    
    try {
      await _authService.sendPasswordRecovery(email: email);
      _clearError();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update user password
  Future<bool> updatePassword({
    required String newPassword,
    String? oldPassword,
  }) async {
    _setLoading(true);
    
    try {
      await _authService.updatePassword(
        newPassword: newPassword,
        oldPassword: oldPassword,
      );
      _clearError();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    String? name,
    String? email,
  }) async {
    _setLoading(true);
    
    try {
      _user = await _authService.updateProfile(
        name: name,
        email: email,
      );
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Send email verification
  Future<bool> sendEmailVerification() async {
    _setLoading(true);
    
    try {
      await _authService.sendEmailVerification();
      _clearError();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Clear error message
  void clearError() {
    _clearError();
  }

  // Private methods
  void _setState(AuthState newState) {
    _state = newState;
    _clearError();
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _state = AuthState.error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
