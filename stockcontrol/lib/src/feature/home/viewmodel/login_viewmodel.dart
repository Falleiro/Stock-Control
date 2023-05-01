import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_control/src/common/AuthService.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle error
      print(e.message);
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
