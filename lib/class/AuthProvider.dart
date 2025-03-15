import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _authToken;

  String? get authToken => _authToken;

  // Set the authentication token
  void setAuthToken(String token) {
    _authToken = token;
    notifyListeners(); // Notify listeners when the token changes
  }

  // Clear the authentication token
  void clearAuthToken() {
    _authToken = null;
    notifyListeners();
  }
}
