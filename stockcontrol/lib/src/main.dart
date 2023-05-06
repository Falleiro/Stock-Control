import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stock_control/src/feature/home/repository/dao/itens_dao.dart';
import '../src/feature/home/repository/dao/estabelecimento_dao.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() {
  final EstabelecimentoDao _estabelecimentoDao = EstabelecimentoDao();
  final ItemDao _itemDao = ItemDao();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  _estabelecimentoDao
      .findAll()
      .then((estabelecimentos) => debugPrint(estabelecimentos.toString()));
  _itemDao.findAll().then((itens) => debugPrint(itens.toString()));
}
