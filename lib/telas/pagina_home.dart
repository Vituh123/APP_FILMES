import 'package:flutter/material.dart';
import '../modelos/filme.dart';
import 'pagina_formulario.dart';

class PaginaHome extends StatefulWidget {
  final String nomeGrupo;
  const PaginaHome({super.key, required this.nomeGrupo});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  List<Filme> filmes = [];

  void _mostrarGrupo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Grupo'),
        content: Text(widget.nomeGrupo),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _abrirFormulario({Filme? filme}) async {
    final resultado = await Navigator.push<Filme>(
      context,
      MaterialPageRoute(builder: (_) => PaginaFormulario(filme: filme)),
    );
    if (resultado != null) {
      setState(() {
        if (filme != null) {
          final index = filmes.indexWhere((f) => f.id == filme.id);
          filmes[index] = resultado;
        } else {
          resultado.id = DateTime.now().millisecondsSinceEpoch;
          filmes.add(resultado);
        }
      });
    }
  }

  void _removerFilme(int id) {
    setState(() {
      filmes.removeWhere((f) => f.id == id);
    });
  }

  Widget _estrelinhas(double nota) {
    int cheias = nota.floor();
    bool meia = (nota - cheias) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < cheias) return const Icon(Icons.star, color: Colors.amber, size: 16);
        if (i == cheias && meia) return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        return const Icon(Icons.star_border, color: Colors.grey, size: 16);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Filmes Cadastrados'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
        actions: [
          IconButton(
            onPressed: _mostrarGrupo,
            icon: const Icon(Icons.group),
          ),
        ],
      ),
      body: filmes.isEmpty
          ? const Center(
        child: Text('Nenhum filme cadastrado.'),
      )
          : Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: filmes.length,
          itemBuilder: (context, index) {
            final filme = filmes[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('Exibir Dados'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                '/detalhes',
                                arguments: filme,
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Alterar'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                '/formulario',
                                arguments: filme,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      filme.imagemUrl,
                      width: 55,
                      height: 85,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey[300], width: 55, height: 85),
                    ),
                  ),
                  title: Text(
                    filme.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${filme.genero} • ${filme.ano} • ${filme.duracao} min'),
                      Row(
                        children: [
                          _estrelinhas(filme.pontuacao),
                          const SizedBox(width: 4),
                          Text(filme.pontuacao.toStringAsFixed(1)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        label: const Text('Novo'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey[700],
      ),
    );
  }
}
