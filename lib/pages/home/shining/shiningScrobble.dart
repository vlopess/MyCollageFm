// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:shimmer/shimmer.dart';

class ShiningScrobble extends StatelessWidget {
  const ShiningScrobble({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text('Scrobbling now', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000),
              child: Container(
                height: 75,
                decoration: BoxDecoration(color: Couleurs.grey100,borderRadius: BorderRadius.circular(15.0))
              ),
            ),
          ),
        ],
      ),
    );
  }
}