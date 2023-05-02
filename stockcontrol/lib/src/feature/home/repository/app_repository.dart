import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/estabelecimento_dao.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'stockcontrol.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(EstabelecimentoDao.tableSql);
  }, version: 1
      // Caso queira reiniciar o banco de dados, altere a versão para 2, descomente o código abaixo e de um Reiniciar, após isso volte para a versão anterior e rode de novo o projeto
      // onDowngrade: onDatabaseDowngradeDelete,
      );
}
