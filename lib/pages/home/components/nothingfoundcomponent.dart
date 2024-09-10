
import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class NothingFoundComponent extends StatelessWidget {
  final String title;
  const NothingFoundComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const  EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [        
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
            )),
          Container(
            decoration: BoxDecoration(
              color: Couleurs.greyMedium,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 100,
            child: const Center(child: Text("Nothing Found",  style: TextStyle(fontFamily: 'Barlow', color: Couleurs.primaryColor, fontWeight: FontWeight.bold),)),
          ),
        ],
      ),
    );
  }
}
