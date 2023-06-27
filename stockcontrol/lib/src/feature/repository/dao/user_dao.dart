import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_control/src/feature/repository/app_repository.dart';
import 'package:stock_control/src/feature/viewmodel/user_viewmodel.dart';

class UserDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id TEXT PRIMARY KEY AUTOINCREMENT)';

  static const String _tableName = 'usuarios';
  static const String _id = 'id';

  Future<int> save(User usuario) async {
    final Database db = await getDataBase();
    Map<String, dynamic> userMap = _toMap(usuario);
    debugPrint('Esta sendo salvo um usuario com o id: $_id');
    return db.insert(_tableName, userMap);
  }

  Map<String, dynamic> _toMap(User usuario) {
    final Map<String, dynamic> userMap = {};
    userMap[_id] = usuario.id.toString();
    return userMap;
  }

  Future<List<User>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<User> userList = _toList(result);
    return userList;
  }

  List<User> _toList(List<Map<String, dynamic>> result) {
    final List<User> usuarios = [];
    for (Map<String, dynamic> row in result) {
      final User usuario = User(
        row[_id].toString(),
      );
      usuarios.add(usuario);
    }

    return usuarios;
  }

  delete(int userId) async {
    final Database db = await getDataBase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [userId],
    );
  }
}
