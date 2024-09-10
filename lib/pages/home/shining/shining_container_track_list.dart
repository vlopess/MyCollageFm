// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:shimmer/shimmer.dart';

class SiningContainerTrakList extends StatelessWidget {
  final String title;
  final double height;
  const SiningContainerTrakList({super.key, this.height = 300, required this.title});

  @override
  Widget build(BuildContext context) {
    int itemCount = (height / 100).ceil();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Couleurs.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(                  
              color: Couleurs.greyMedium,
              borderRadius: BorderRadius.all(Radius.circular(20))                  
            ),
            height: height,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000),
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(color: Couleurs.secondary,borderRadius: BorderRadius.circular(15.0))
                    ),
                  ),
                );
              }
            ),
          )
        ),
      ],
    );
  }
}

