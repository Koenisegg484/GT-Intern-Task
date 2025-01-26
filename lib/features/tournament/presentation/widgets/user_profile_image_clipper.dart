import 'package:flutter/material.dart';

class UserProfileImageFrameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.47, size.height * 0.06);
    path_0.lineTo(size.width * 0.09, size.height * 0.225);
    path_0.lineTo(size.width * 0.17, size.height * 0.7904714);
    path_0.lineTo(size.width * 0.48, size.height * 0.99);
    path_0.lineTo(size.width * 0.78, size.height * 0.8);
    path_0.lineTo(size.width * 0.85, size.height * 0.225);
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
