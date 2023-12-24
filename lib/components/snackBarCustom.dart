// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class SnackBarCustom extends StatelessWidget {
  final String title;
  final Color cor;
  const SnackBarCustom({
    super.key, 
    required this.title, 
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Couleurs.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    fontFamily: 'Barlow'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
