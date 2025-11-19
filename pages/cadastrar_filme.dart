import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../repositories/filme_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CadastrarFilmePage extends StatefulWidget {
  const CadastrarFilmePage({super.key});

  @override
  State<CadastrarFilmePage> createState() => _CadastrarFilmePageState();
}

class _CadastrarFilmePageState extends State<CadastrarFilmePage> {
  final form = GlobalKey<FormState>();
  final repo = FilmeRepository();

  String faixa = "Livre";
  double rating = 0;

  final url = TextEditingController();
  final titulo = TextEditingController();
  final genero = TextEditingController();
  final duracao = TextEditingController();
  final descricao = TextEditingController();
  final ano = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Filme")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                controller: url,
                decoration: InputDecoration(labelText: "URL da imagem"),
                validator: (v) => v!.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                controller: titulo,
                decoration: InputDecoration(labelText: "Título"),
                validator: (v) => v!.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                controller: genero,
                decoration: InputDecoration(labelText: "Gênero"),
              ),
              DropdownButtonFormField(
                initialValue: faixa,
                items: ["Livre", "10", "12", "14", "16", "18"]
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (v) => faixa = v!,
                decoration: InputDecoration(labelText: "Faixa Etária"),
              ),
              TextFormField(
                controller: duracao,
                decoration: InputDecoration(labelText: "Duração"),
              ),
              SizedBox(height: 10),
              Text("Pontuação"),
              RatingBar.builder(
                minRating: 0,
                maxRating: 5,
                itemSize: 35,
                allowHalfRating: true,
                itemBuilder: (c, _) => Icon(Icons.star),
                onRatingUpdate: (val) => rating = val,
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
                validator: (v) =>
                v!.isEmpty ? "Campo obrigatório" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print("➡ BOTÃO SALVAR CLICADO");

                  if (form.currentState!.validate()) {
                    print("➡ FORMULÁRIO VÁLIDO");

                    try {
                      // Proteção extra
                      final anoConvertido =
                          int.tryParse(ano.text) ?? 0;

                      await repo.insert(
                        Filme(
                          urlImagem: url.text,
                          titulo: titulo.text,
                          genero: genero.text,
                          faixaEtaria: faixa,
                          duracao: duracao.text,
                          pontuacao: rating,
                          descricao: descricao.text,
                          ano: anoConvertido,
                        ),
                      );

                      print("✔ FILME SALVO COM SUCESSO!");

                      if (!context.mounted) return;
                      Navigator.pop(context);
                    } catch (e) {
                      print("❌ ERRO AO SALVAR: $e");
                    }
                  } else {
                    print("❌ FORMULÁRIO INVÁLIDO");
                  }
                },
                child: Text("Salvar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
