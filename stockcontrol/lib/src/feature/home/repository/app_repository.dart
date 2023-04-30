import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_control/src/feature/home/viewmodel/stockcreate_viewmodel.dart';

Future<Database> createDataBase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'stockcontrol.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE estabelecimentos('
            'name TEXT) ');
      },
      version: 1,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  });
}

Future<int> save(Estabelecimento estabelecimento) {
  return createDataBase().then((db) {
    final Map<String, dynamic> estabelecimentoMap = Map();
    estabelecimentoMap['name'] = estabelecimento.name;
    return db.insert('estabelecimentos', estabelecimentoMap);
  });
}

Future<List<Estabelecimento>> findAll() {
  return createDataBase().then((db) {
    return db.query('estabelecimentos').then((maps) {
      final List<Estabelecimento> estabelecimentos = [];
      for (Map<String, dynamic> map in maps) {
        final Estabelecimento estabelecimento = Estabelecimento(
          map['name'],
        );
        estabelecimentos.add(estabelecimento);
      }
      return estabelecimentos;
    });
  });
}
