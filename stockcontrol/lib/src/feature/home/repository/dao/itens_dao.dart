import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../viewmodel/itens_viewmodel.dart';
import '../app_repository.dart';

class ItemDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_name TEXT, '
      '$_qtd INTEGER, '
      '$_idEstabelecimento INTEGER,'
      'FOREIGN KEY ($_idEstabelecimento) REFERENCES estabelecimentos(id))';

  static const String _tableName = 'itens';
  static const String _id = 'id_item';
  static const String _name = 'name';
  static const String _idEstabelecimento = 'estabelecimento_id';
  static const String _qtd = 'qtd';

  Future<int> save(Item item) async {
    final Database db = await getDataBase();
    Map<String, dynamic> itemMap = _toMap(item);
    return db.insert(_tableName, itemMap);
  }

  Map<String, dynamic> _toMap(Item item) {
    final Map<String, dynamic> itemMap = {};
    itemMap[_name] = item.name;
    itemMap[_idEstabelecimento] = item.idEstabelecimento;
    itemMap[_qtd] = item.qtd;
    return itemMap;
  }

  Future<List<Item>> findAllByEstabelecimento(int idEstabelecimento) async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName,
        where: '$_idEstabelecimento = ?', whereArgs: [idEstabelecimento]);
    List<Item> itens = _toList(result);
    debugPrint('Lista que irá aparecer: $itens');
    return itens;
  }

  Future<List<Item>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Item> itens = _toList(result);
    return itens;
  }

  List<Item> _toList(List<Map<String, dynamic>> result) {
    final List<Item> items = [];
    for (Map<String, dynamic> row in result) {
      final Item item = Item(
        row[_name],
        row[_idEstabelecimento],
        row[_id],
        row[_qtd],
      );
      items.add(item);
    }
    return items;
  }
}
