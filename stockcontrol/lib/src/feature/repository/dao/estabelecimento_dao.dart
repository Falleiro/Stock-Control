import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../viewmodel/estabelecimento_viewmodel.dart';
import '../app_repository.dart';

class EstabelecimentoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_name TEXT UNIQUE, '
      '$_cep INTEGER, '
      '$_estado TEXT, '
      '$_cidade TEXT,'
      'FOREIGN KEY ($_userId) REFERENCES usuarios(id))';

  static const String _tableName = 'estabelecimentos';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _cep = 'cep';
  static const String _estado = 'estado';
  static const String _cidade = 'cidade';
  static const String _userId = 'user_id';

  Future<int> save(Estabelecimento estabelecimento) async {
    final Database db = await getDataBase();
    Map<String, dynamic> estabelecimentoMap = _toMap(estabelecimento);
    return db.insert(_tableName, estabelecimentoMap);
  }

  Map<String, dynamic> _toMap(Estabelecimento estabelecimento) {
    final Map<String, dynamic> estabelecimentoMap = {};
    estabelecimentoMap[_name] = estabelecimento.name;
    estabelecimentoMap[_cep] = estabelecimento.cep;
    estabelecimentoMap[_estado] = estabelecimento.estado;
    estabelecimentoMap[_cidade] = estabelecimento.cidade;
    return estabelecimentoMap;
  }

  Future<List<Estabelecimento>> findAllByUser(String userId) async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: '$_userId = ?', whereArgs: [userId]);
    List<Estabelecimento> estabelecimentos = _toList(result);
    debugPrint('Lista que irá aparecer: $estabelecimentos');
    return estabelecimentos;
  }

  Future<List<Estabelecimento>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Estabelecimento> estabelecimentos = _toList(result);
    return estabelecimentos;
  }

  List<Estabelecimento> _toList(List<Map<String, dynamic>> result) {
    final List<Estabelecimento> estabelecimentos = [];
    for (Map<String, dynamic> row in result) {
      final Estabelecimento estabelecimento = Estabelecimento(
        row[_id],
        row[_name],
        row[_cep],
        row[_estado],
        row[_cidade],
      );
      debugPrint('Lista que irá aparecer: $estabelecimento');
      estabelecimentos.add(estabelecimento);
    }

    return estabelecimentos;
  }

  Future<void> updateName(int estabelecimentoId, String newName) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_name: newName},
      where: '$_id = ?',
      whereArgs: [estabelecimentoId],
    );
  }

  Future<void> updateCep(int estabelecimentoId, int newCep) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_cep: newCep},
      where: '$_id = ?',
      whereArgs: [estabelecimentoId],
    );
  }

  Future<void> updateEstado(int estabelecimentoId, String newEstado) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_estado: newEstado},
      where: '$_id = ?',
      whereArgs: [estabelecimentoId],
    );
  }

  Future<void> updateCidade(int estabelecimentoId, String newCidade) async {
    final Database db = await getDataBase();
    await db.update(
      _tableName,
      {_cidade: newCidade},
      where: '$_id = ?',
      whereArgs: [estabelecimentoId],
    );
  }

  delete(int estabelecimentoId) async {
    final Database db = await getDataBase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [estabelecimentoId],
    );
  }
}
