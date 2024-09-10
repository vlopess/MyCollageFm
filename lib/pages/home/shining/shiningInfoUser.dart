// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:shimmer/shimmer.dart';

class ShiningInfoUser extends StatelessWidget {
  const ShiningInfoUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(                                  
      children: [
        Column(
          children: [
            const Padding(
              padding:  EdgeInsets.only(left: 8.0, top: 5),
              child:  Text('Scrobbles',overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
            ),
            Shimmer.fromColors(baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000), child: Container(width: 54,height: 14, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.secondary))),
          ],
        ),                        
        Column(
          children: [
            const Padding(
              padding:  EdgeInsets.only(left: 9.0, top: 5),
              child:  Text('Artists',overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
            ),
            Shimmer.fromColors(baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000), child: Container(width: 44,height: 14, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.secondary))),
          ],
        ),                                                            
      ],
  );
  }
}