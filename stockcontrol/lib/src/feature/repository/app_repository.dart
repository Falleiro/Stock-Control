import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/estabelecimento_dao.dart';
import 'dao/itens_dao.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'stockcontrol.db');

  // Descomentar caso queira apagar
  // Exclui o banco de dados antigo
  bool exists = await databaseExists(path);
  if (exists) {
    await deleteDatabase(path);
  }

  // Cria um novo banco de dados
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(EstabelecimentoDao.tableSql);
      db.execute(ItemDao.tableSql);
    },
    version: 1,
  );
}
