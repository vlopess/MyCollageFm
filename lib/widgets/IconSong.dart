// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IconSong extends StatelessWidget {
  const IconSong({super.key});

  @override
  Widget build(BuildContext context) {
  return SizedBox(width: 125, child: LottieBuilder.asset("assets/json/simbolSong.json",repeat: true));
  }
}