import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/src/feature/home/repository/dao/itens_dao.dart';
import '../src/feature/home/repository/dao/estabelecimento_dao.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_control/src/services/firebase_auth_service.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD-XfAUwc0i3wY0gwWu5APWaDcwS3eXVnQ",
      authDomain: "stock-control-pdm.firebaseapp.com",
      databaseURL: "YOUR_DATABASE_URL",
      projectId: "stock-control-pdm",
      storageBucket: "stock-control-pdm.appspot.com",
      messagingSenderId: "598026633058",
      appId: "1:598026633058:web:5a6438ddadf2245aa8f63b",
    ),
  );
  final EstabelecimentoDao _estabelecimentoDao = EstabelecimentoDao();
  final ItemDao _itemDao = ItemDao();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  _estabelecimentoDao
      .findAll()
      .then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
  _itemDao.findAll().then((itens) => debugPrint(itens.toString()));
}
