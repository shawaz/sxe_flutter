import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sxe/data/services/auth_service.dart';

class SessionProvider extends ChangeNotifier {
  final AuthService _authService;
  Timer? _sessionTimer;
  Timer? _warningTimer;
  
  static const Duration _sessionTimeout = Duration(hours: 24);
  static const Duration _warningTime = Duration(minutes: 5);
  
  bool _showSessionWarning = false;
  DateTime? _lastActivity;

  SessionProvider(this._authService);

  bool get showSessionWarning => _showSessionWarning;
  DateTime? get lastActivity => _lastActivity;

  /// Start session monitoring
  void startSessionMonitoring() {
    _updateLastActivity();
    _resetSessionTimer();
  }

  /// Stop session monitoring
  void stopSessionMonitoring() {
    _sessionTimer?.cancel();
    _warningTimer?.cancel();
    _showSessionWarning = false;
    notifyListeners();
  }

  /// Update last activity timestamp
  void updateActivity() {
    _updateLastActivity();
    _resetSessionTimer();
    
    if (_showSessionWarning) {
      _showSessionWarning = false;
      notifyListeners();
    }
  }

  /// Extend session
  Future<bool> extendSession() async {
    try {
      final success = await _authService.refreshSession();
      if (success) {
        _updateLastActivity();
        _resetSessionTimer();
        _showSessionWarning = false;
        notifyListeners();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  /// Force logout due to session expiry
  Future<void> forceLogout() async {
    stopSessionMonitoring();
    await _authService.logout();
  }

  // Private methods
  void _updateLastActivity() {
    _lastActivity = DateTime.now();
  }

  void _resetSessionTimer() {
    _sessionTimer?.cancel();
    _warningTimer?.cancel();

    // Set warning timer (5 minutes before session expires)
    _warningTimer = Timer(_sessionTimeout - _warningTime, () {
      _showSessionWarning = true;
      notifyListeners();
    });

    // Set session expiry timer
    _sessionTimer = Timer(_sessionTimeout, () {
      forceLogout();
    });
  }

  @override
  void dispose() {
    stopSessionMonitoring();
    super.dispose();
  }
}
