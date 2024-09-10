import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

/// Cria Widget que exibe container circular
///
/// Se comporta de forma diferente quando o atributo da classe está ativo
/// {@category Components}
class Indicador extends StatelessWidget {
  const Indicador({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 10,
        width: active ? 18 : 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: active
              ? Couleurs.primaryColor
              : Couleurs.grey200,
        ),
      ),
    );
  }
}