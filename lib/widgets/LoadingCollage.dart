// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingCollage extends StatelessWidget {
  final double? width;
  const LoadingCollage({
    super.key,    
    this.width,
  });

  @override
  Widget build(BuildContext context) {
  return SizedBox(width: width, child: LottieBuilder.asset("assets/json/LoadingCollage.json"));
  }
}