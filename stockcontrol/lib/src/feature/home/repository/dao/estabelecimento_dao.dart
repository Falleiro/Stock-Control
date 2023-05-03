import 'package:sqflite/sqflite.dart';

import '../../viewmodel/stockcreate_viewmodel.dart';
import '../app_repository.dart';

class EstabelecimentoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      // '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT) ';

  static const String _tableName = 'estabelecimentos';
  // static const String _id = 'id';
  static const String _name = 'name';

  Future<int> save(Estabelecimento estabelecimento) async {
    final Database db = await getDataBase();
    Map<String, dynamic> estabelecimentoMap = _toMap(estabelecimento);
    return db.insert(_tableName, estabelecimentoMap);
  }

  Map<String, dynamic> _toMap(Estabelecimento estabelecimento) {
    final Map<String, dynamic> estabelecimentoMap = {};
    estabelecimentoMap[_name] = estabelecimento.name;
    return estabelecimentoMap;
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
        row[_name],
      );
      estabelecimentos.add(estabelecimento);
    }
    return estabelecimentos;
  }
}
