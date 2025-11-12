import 'package:flutter/material.dart';
import 'telas/pagina_home.dart';
import 'telas/pagina_detalhes.dart';
import 'telas/pagina_formulario.dart';
import 'utilidades/tema.dart';

void main() {
  runApp(const AplicativoFilmes());
}

class AplicativoFilmes extends StatelessWidget {
  const AplicativoFilmes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes 🎬',
      debugShowCheckedModeBanner: false,
      theme: TemaApp.temaPadrao,
      initialRoute: '/',
      routes: {
        '/': (context) => const PaginaHome(
          nomeGrupo: 'Vitor Lucas, Miquéias da Costa, Bruno Weslley',
        ),
        '/detalhes': (context) => const PaginaDetalhes(),
        '/formulario': (context) => const PaginaFormulario(),
      },
    );
  }
}
