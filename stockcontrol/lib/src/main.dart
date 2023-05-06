import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/src/feature/home/repository/dao/itens_dao.dart';
import '../src/feature/home/repository/dao/estabelecimento_dao.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';
import 'package:stock_control/firebase_options.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final EstabelecimentoDao _estabelecimentoDao = EstabelecimentoDao();
  final ItemDao _itemDao = ItemDao();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  _estabelecimentoDao
      .findAll()
      .then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
  _itemDao.findAll().then((itens) => debugPrint(itens.toString()));
}
