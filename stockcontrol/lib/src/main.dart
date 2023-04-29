import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/services/auth_services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'app_module.dart';
import 'app_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  // Inicialize o Firebase
  setUpAll(() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyD-XfAUwc0i3wY0gwWu5APWaDcwS3eXVnQ",
        authDomain: "stock-control-pdm.firebaseapp.com",
        projectId: "stock-control-pdm",
        storageBucket: "stock-control-pdm.appspot.com",
        messagingSenderId: "598026633058",
        appId: "1:598026633058:web:5a6438ddadf2245aa8f63b",
        measurementId: "G-R31PW1BFZF",
      ),
    );
  });

  group('Firebase Auth Tests', () {
    test('Sign in with email and password', () async {
      final FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: 'empresaa.stockcontrol@gmail.com', password: 'control@123');

      expect(userCredential.user, isNotNull);
    });
  });
}
