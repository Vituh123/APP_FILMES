import 'package:flutter/material.dart';
import '../modelos/filme.dart';

class PaginaFormulario extends StatefulWidget {
  final Filme? filme;
  const PaginaFormulario({super.key, this.filme});

  @override
  State<PaginaFormulario> createState() => _PaginaFormularioState();
}

class _PaginaFormularioState extends State<PaginaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final List<String> faixas = ['Livre', '10', '12', '14', '16', '18'];

  late TextEditingController tituloC;
  late TextEditingController generoC;
  late TextEditingController duracaoC;
  late TextEditingController descricaoC;
  late TextEditingController anoC;
  late TextEditingController imagemC;
  String faixa = 'Livre';
  double pontuacao = 0.0;

  @override
  void initState() {
    super.initState();
    final f = widget.filme;
    tituloC = TextEditingController(text: f?.titulo ?? '');
    generoC = TextEditingController(text: f?.genero ?? '');
    duracaoC = TextEditingController(text: f?.duracao.toString() ?? '');
    descricaoC = TextEditingController(text: f?.descricao ?? '');
    anoC = TextEditingController(text: f?.ano.toString() ?? '');
    imagemC = TextEditingController(text: f?.imagemUrl ?? '');
    faixa = f?.faixaEtaria ?? 'Livre';
    pontuacao = f?.pontuacao ?? 0.0;
  }

  Widget _estrelinhas() {
    return Row(
      children: List.generate(5, (i) {
        final v = (i + 1).toDouble();
        return IconButton(
          icon: Icon(
            pontuacao >= v ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => setState(() => pontuacao = v),
        );
      }),
    );
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final filme = Filme(
        id: widget.filme?.id,
        titulo: tituloC.text.trim(),
        genero: generoC.text.trim(),
        faixaEtaria: faixa,
        duracao: int.tryParse(duracaoC.text) ?? 0,
        pontuacao: pontuacao,
        descricao: descricaoC.text.trim(),
        ano: int.tryParse(anoC.text) ?? 0,
        imagemUrl: imagemC.text.trim(),
      );
      Navigator.pop(context, filme);
    }
  }

  @override
  Widget build(BuildContext context) {
    final edicao = widget.filme != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(edicao ? 'Editar Filme' : 'Cadastrar Filme'),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: tituloC,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: generoC,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              DropdownButtonFormField(
                value: faixa,
                items: faixas
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (v) => setState(() => faixa = v ?? 'Livre'),
                decoration: const InputDecoration(labelText: 'Faixa Etária'),
              ),
              TextFormField(
                controller: duracaoC,
                decoration: const InputDecoration(labelText: 'Duração (min)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              const Text('Pontuação'),
              _estrelinhas(),
              TextFormField(
                controller: anoC,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: imagemC,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextFormField(
                controller: descricaoC,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(edicao ? 'Salvar Alterações' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
