import 'package:flutter/material.dart';
import '../modelos/filme.dart';
import '../componentes/estrela_widget.dart';

class PaginaDetalhes extends StatelessWidget {
  final Filme? filme;

  const PaginaDetalhes({super.key, this.filme});

  @override
  Widget build(BuildContext context) {
    // Caso o filme seja nulo (erro de navegação, por exemplo)
    if (filme == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Filme'),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: const Center(
          child: Text(
            'Nenhum filme selecionado.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    // Caso haja filme, mostra os detalhes
    return Scaffold(
      appBar: AppBar(
        title: Text(filme!.titulo),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  filme!.imagemUrl,
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    width: 200,
                    height: 300,
                    child: const Icon(Icons.broken_image, size: 80),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${filme!.genero} • ${filme!.ano} • ${filme!.duracao} min',
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            EstrelaWidget(pontuacao: filme!.pontuacao),
            const SizedBox(height: 16),
            Text(
              filme!.descricao,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
