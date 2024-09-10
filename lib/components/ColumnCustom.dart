// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class ColumnCustom extends StatelessWidget {
  final String? label;  
  final String? title;

  const ColumnCustom({super.key, required this.label, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(        
        children: [
          Text(label??'',overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),                        
          Text(title??'',overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", color: Couleurs.white, fontSize: 13)),
        ],
      ),
    );
  }
}