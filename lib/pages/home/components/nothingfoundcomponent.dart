
import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

Widget nothingfoundcomponent({required String title}) => Padding(
    padding: const  EdgeInsets.only(left: 10, right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [        
        Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: const TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
        const SizedBox(
          height: 100,
          child: Center(child: Text("Nothing Found",  style: TextStyle(fontFamily: 'Barlow', color: Couleurs.primaryColor, fontWeight: FontWeight.bold),)),
        ),
      ],
    ),
  );