import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/estabelecimento_dao.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'stockcontrol.db');

  // Descomentar caso queira apagar
  // bool exists = await databaseExists(path);
  // if (exists) {
  //   // Exclui o banco de dados antigo
  //   await deleteDatabase(path);
  // }

  // Cria um novo banco de dados
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(EstabelecimentoDao.tableSql);
    },
    version: 1,
  );
}
