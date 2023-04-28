import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app_module.dart';
import 'app_widget.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized;

  await Firebase.initializeApp{
    options: DefaultFirebaseOptions.currentPlataform,
  };

  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
