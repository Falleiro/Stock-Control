import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      usuario = userCredential.user;
      notifyListeners();
      return userCredential;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      usuario = null;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
