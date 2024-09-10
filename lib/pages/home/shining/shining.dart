import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:shimmer/shimmer.dart';

class Shining extends StatelessWidget {
  final String title;
  const Shining({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [        
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: const TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
                ),
              ],
            )),
          Container(
            decoration: BoxDecoration(
              color: Couleurs.greyMedium,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 200,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey.shade900,
                highlightColor: Couleurs.grey200,
                period: const Duration(milliseconds: 2000),                                
                child: Container(width: 160, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
              ), 
              separatorBuilder: (context, index) => const SizedBox(width: 12), 
              itemCount: 4
            ),
          ),
        ],
      ),
    );
  }
}