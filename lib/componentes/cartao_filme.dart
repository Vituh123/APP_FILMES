import 'package:flutter/material.dart';
import '../modelos/filme.dart';
import 'estrela_widget.dart';

class CartaoFilme extends StatelessWidget {
  final Filme filme;
  final VoidCallback? aoClicar;
  const CartaoFilme({super.key, required this.filme, this.aoClicar});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: aoClicar,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
                  EstrelaWidget(pontuacao: filme.pontuacao),
                  const SizedBox(width: 4),
                  Text(filme.pontuacao.toStringAsFixed(1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
