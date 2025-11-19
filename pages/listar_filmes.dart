import 'package:flutter/material.dart';
import '../repositories/filme_repository.dart';
import '../models/filme.dart';
import 'cadastrar_filme.dart';
import 'detalhes_filme.dart';
import 'editar_filme.dart';

class ListarFilmesPage extends StatefulWidget {
  @override
  State<ListarFilmesPage> createState() => _ListarFilmesPageState();
}

class _ListarFilmesPageState extends State<ListarFilmesPage> {
  final repo = FilmeRepository();
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  carregar() async {
    filmes = await repo.getAll();
    setState(() {});
  }

  abrirMenu(Filme f) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Exibir Dados"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetalhesFilmePage(filme: f)));
            },
          ),
          ListTile(
            title: Text("Alterar"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditarFilmePage(filme: f)))
                  .then((_) => carregar());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Grupo"),
                  content: Text("Vitor Lucas Farias Ramos, Miquéias da Costa Sousa Silva e Bruno Weslley Silva de Medeiros"),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CadastrarFilmePage()),
        ).then((_) => carregar()),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, i) {
          final f = filmes[i];
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (_) async {
              await repo.delete(f.id!);
              carregar();
            },
            child: ListTile(
              leading: Image.network(f.urlImagem, width: 60, fit: BoxFit.cover),
              title: Text(f.titulo),
              subtitle: Text("${f.genero} • ${f.pontuacao}/5"),
              onTap: () => abrirMenu(f),
            ),
          );
        },
      ),
    );
  }
}
