import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../repositories/filme_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EditarFilmePage extends StatefulWidget {
  final Filme filme;

  EditarFilmePage({required this.filme});

  @override
  State<EditarFilmePage> createState() => _EditarFilmePageState();
}

class _EditarFilmePageState extends State<EditarFilmePage> {
  final form = GlobalKey<FormState>();
  final repo = FilmeRepository();

  late String faixa;
  late double rating;

  late TextEditingController url;
  late TextEditingController titulo;
  late TextEditingController genero;
  late TextEditingController duracao;
  late TextEditingController descricao;
  late TextEditingController ano;

  @override
  void initState() {
    super.initState();
    url = TextEditingController(text: widget.filme.urlImagem);
    titulo = TextEditingController(text: widget.filme.titulo);
    genero = TextEditingController(text: widget.filme.genero);
    duracao = TextEditingController(text: widget.filme.duracao);
    descricao = TextEditingController(text: widget.filme.descricao);
    ano = TextEditingController(text: widget.filme.ano.toString());
    faixa = widget.filme.faixaEtaria;
    rating = widget.filme.pontuacao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Filme")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                controller: url,
                decoration: InputDecoration(labelText: "URL"),
              ),
              TextFormField(
                controller: titulo,
                decoration: InputDecoration(labelText: "Título"),
              ),
              TextFormField(
                controller: genero,
                decoration: InputDecoration(labelText: "Gênero"),
              ),
              DropdownButtonFormField(
                value: faixa,
                items: ["Livre","10","12","14","16","18"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => faixa = v!,
              ),
              TextFormField(
                controller: duracao,
                decoration: InputDecoration(labelText: "Duração"),
              ),
              Text("Pontuação"),
              RatingBar.builder(
                initialRating: rating,
                onRatingUpdate: (v) => rating = v,
                itemBuilder: (_, __) => Icon(Icons.star),
              ),
              TextFormField(
                controller: descricao,
                decoration: InputDecoration(labelText: "Descrição"),
                maxLines: 5,
              ),
              TextFormField(
                controller: ano,
                decoration: InputDecoration(labelText: "Ano"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final f = widget.filme;
                  await repo.update(Filme(
                    id: f.id,
                    urlImagem: url.text,
                    titulo: titulo.text,
                    genero: genero.text,
                    faixaEtaria: faixa,
                    duracao: duracao.text,
                    pontuacao: rating,
                    descricao: descricao.text,
                    ano: int.parse(ano.text),
                  ));
                  Navigator.pop(context);
                },
                child: Text("Salvar Alterações"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
