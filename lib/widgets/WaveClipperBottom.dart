// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

class WaveClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 30);

    path.quadraticBezierTo(size.width / 7, 0, size.width / 5 + 45, 30);
    path.quadraticBezierTo(size.width / 1.5, size.height / 2, size.width, size.height / 2 -30);
    path.lineTo(size.width, size.width);
    path.lineTo(0, size.height);
    
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
  
}