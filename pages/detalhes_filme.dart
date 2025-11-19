import 'package:flutter/material.dart';
import '../models/filme.dart';

class DetalhesFilmePage extends StatelessWidget {
  final Filme filme;

  DetalhesFilmePage({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(filme.titulo)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(filme.urlImagem),
            SizedBox(height: 10),
            Text("Gênero: ${filme.genero}"),
            Text("Faixa Etária: ${filme.faixaEtaria}"),
            Text("Duração: ${filme.duracao}"),
            Text("Ano: ${filme.ano}"),
            Text("Pontuação: ${filme.pontuacao}"),
            SizedBox(height: 10),
            Text(filme.descricao),
          ],
        ),
      ),
    );
  }
}
