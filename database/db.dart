import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> getDb() async {
    final path = join(await getDatabasesPath(), 'filmes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute("""
          CREATE TABLE filmes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            urlImagem TEXT,
            titulo TEXT,
            genero TEXT,
            faixaEtaria TEXT,
            duracao TEXT,
            pontuacao REAL,
            descricao TEXT,
            ano INTEGER
          );
        """);
      },
    );
  }
}
