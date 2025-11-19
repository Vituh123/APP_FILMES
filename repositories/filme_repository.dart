import '../database/db.dart';
import '../models/filme.dart';

class FilmeRepository {
  Future<int> insert(Filme filme) async {
    final db = await DB.getDb();
    return db.insert("filmes", filme.toMap());
  }

  Future<List<Filme>> getAll() async {
    final db = await DB.getDb();
    final maps = await db.query("filmes");
    return maps.map((e) => Filme.fromMap(e)).toList();
  }

  Future<int> update(Filme filme) async {
    final db = await DB.getDb();
    return db.update("filmes", filme.toMap(),
        where: "id = ?", whereArgs: [filme.id]);
  }

  Future<int> delete(int id) async {
    final db = await DB.getDb();
    return db.delete("filmes", where: "id = ?", whereArgs: [id]);
  }
}
