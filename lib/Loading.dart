// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  return SizedBox(width: 75, child: LottieBuilder.asset("assets/json/loading.json"));
  }
}