// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:shimmer/shimmer.dart';

class ShiningLovedTracks extends StatelessWidget {
  const ShiningLovedTracks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [        
          const Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [              
                Text('Loved Tracks', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
                Icon(Icons.favorite, color: Colors.red,),
              ],
            )),
          SizedBox(
            height: 130,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey.shade900,
                highlightColor: Couleurs.grey200,
                period: const Duration(milliseconds: 2000),                                
                child: Container(width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
              ), 
              separatorBuilder: (context, index) => const SizedBox(width: 12), 
              itemCount: 4
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}