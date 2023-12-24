// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Done extends StatelessWidget {
  const Done({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  return SizedBox(width: 75, child: LottieBuilder.asset("assets/json/done.json",repeat: false));
  }
}