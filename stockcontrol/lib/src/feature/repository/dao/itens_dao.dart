import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../viewmodel/itens_viewmodel.dart';
import '../app_repository.dart';

class ItemDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_name TEXT, '
      '$_qtd INTEGER, '
      '$_idEstabelecimento INTEGER, '
      '$_validade TEXT, '
      '$_lote INTEGER, '
      'FOREIGN KEY ($_idEstabelecimento) REFERENCES estabelecimentos(id))';

  static const String _tableName = 'itens';
  static const String _id = 'id_item';
  static const String _name = 'name';
  static const String _idEstabelecimento = 'estabelecimento_id';
  static const String _qtd = 'qtd';
  static const String _validade = 'validade';
  static const String _lote = 'lote';

  Future<int> save(Item item) async {
    final Database db = await getDataBase();
    Map<String, dynamic> itemMap = _toMap(item);
    return await db.insert(_tableName, itemMap);
  }

  Map<String, dynamic> _toMap(Item item) {
    final Map<String, dynamic> itemMap = {};
    itemMap[_name] = item.name;
    itemMap[_idEstabelecimento] = item.idEstabelecimento;
    itemMap[_qtd] = item.qtd;
    itemMap[_validade] = item.validade;
    itemMap[_lote] = item.lote;
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
        row[_lote],
        row[_validade],
      );
      items.add(item);
    }
    return items;
  }

  Future<void> updateQuantity(int itemId, int newQuantity) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_qtd: newQuantity},
      where: '$_id = ?',
      whereArgs: [itemId],
    );
  }

  Future<void> updateName(int itemId, String newName) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_name: newName},
      where: '$_id = ?',
      whereArgs: [itemId],
    );
  }

  Future<void> updateLote(int itemId, int newLote) async {
    debugPrint('Agora na função do banco de dados função');

    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_lote: newLote},
      where: '$_id = ?',
      whereArgs: [itemId],
    );
    debugPrint('Depois de atualizar');
  }

  Future<void> updateValidade(int itemId, String newValidade) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_validade: newValidade},
      where: '$_id = ?',
      whereArgs: [itemId],
    );
  }

  delete(int itemId) async {
    final Database db = await getDataBase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [itemId],
    );
  }
}
