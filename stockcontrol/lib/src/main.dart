import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
<<<<<<< HEAD
//import 'package:stock_control/src/feature/home/viewmodel/stockcreate_viewmodel.dart';

import 'app_module.dart';
import 'app_widget.dart';
//import 'feature/home/repository/app_repository.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  // findAll().then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
=======
import 'package:stock_control/src/feature/home/viewmodel/stockcreate_viewmodel.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'feature/home/repository/app_repository.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  findAll().then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
>>>>>>> 5037c3a0f141bbc4dc6b6fe1c0a4b363caf2b035
}
