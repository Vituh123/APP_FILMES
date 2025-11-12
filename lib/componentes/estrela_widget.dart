import 'package:flutter/material.dart';

class EstrelaWidget extends StatelessWidget {
  final double pontuacao;
  const EstrelaWidget({super.key, required this.pontuacao});

  @override
  Widget build(BuildContext context) {
    int cheias = pontuacao.floor();
    bool meia = (pontuacao - cheias) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < cheias) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (i == cheias && meia) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey, size: 20);
        }
      }),
    );
  }
}
