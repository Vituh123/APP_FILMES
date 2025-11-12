import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'filme.dart';

class BancoDados {
  static final BancoDados _instancia = BancoDados._interno();
  factory BancoDados() => _instancia;
  BancoDados._interno();

  Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    _banco = await _abrirBanco();
    return _banco!;
  }

  Future<Database> _abrirBanco() async {
    final caminho = await getDatabasesPath();
    final localBanco = join(caminho, 'filmes.db');

    return await openDatabase(
      localBanco,
      version: 1,
      onCreate: (db, versao) async {
        await db.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            genero TEXT,
            faixaEtaria TEXT,
            duracao INTEGER,
            pontuacao REAL,
            descricao TEXT,
            ano INTEGER,
            imagemUrl TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirFilme(Filme filme) async {
    final db = await banco;
    return await db.insert('filmes', {
      'titulo': filme.titulo,
      'genero': filme.genero,
      'faixaEtaria': filme.faixaEtaria,
      'duracao': filme.duracao,
      'pontuacao': filme.pontuacao,
      'descricao': filme.descricao,
      'ano': filme.ano,
      'imagemUrl': filme.imagemUrl,
    });
  }

  Future<List<Filme>> listarFilmes() async {
    final db = await banco;
    final resultado = await db.query('filmes');
    return resultado.map((m) => Filme.fromMap(m)).toList();
  }

  Future<int> atualizarFilme(Filme filme) async {
    final db = await banco;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  Future<int> removerFilme(int id) async {
    final db = await banco;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}
