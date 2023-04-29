import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/services/auth_services.dart';

import 'app_module.dart';
import 'app_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    FirebaseFirestore.instance.collection('teste').add({'teste':'teste'});
    
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
