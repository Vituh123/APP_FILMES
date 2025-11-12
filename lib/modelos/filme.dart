class Filme {
  int? id;
  String titulo;
  String genero;
  String faixaEtaria;
  int duracao;
  double pontuacao;
  String descricao;
  int ano;
  String imagemUrl;

  Filme({
    this.id,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
    required this.imagemUrl,
  });

  // 🔹 Converter um MAPA do banco em um OBJETO Filme
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'] is int
          ? (map['pontuacao'] as int).toDouble()
          : map['pontuacao'],
      descricao: map['descricao'],
      ano: map['ano'],
      imagemUrl: map['imagemUrl'],
    );
  }

  // 🔹 Converter um OBJETO Filme em um MAPA para salvar no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
      'imagemUrl': imagemUrl,
    };
  }
}
