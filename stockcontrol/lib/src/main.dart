import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() {
  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
