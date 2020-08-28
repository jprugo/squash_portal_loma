import 'package:flutter/material.dart';

class CircularClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height/2 - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height/2,
        size.width, size.height/2 - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) {
    return false;
  }
}