import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/src/feature/repository/dao/itens_dao.dart';
import '../src/feature/repository/dao/estabelecimento_dao.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_control/src/services/firebase_options.dart';

import 'settings/app_module.dart';
import 'settings/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final EstabelecimentoDao estabelecimentoDao = EstabelecimentoDao();
  final ItemDao itemDao = ItemDao();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  estabelecimentoDao
      .findAll()
      .then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
  itemDao.findAll().then((itens) => debugPrint(itens.toString()));
}
