import 'dart:math';

import 'package:flutter/material.dart';

class SemiCircleClipper extends CustomClipper<Path> {
  SemiCircleClipper({
    required this.fromTop,
    required this.radius,
  });

  final double fromTop;
  final double radius;

  @override
  Path getClip(Size size) {
    var path = Path();
    path
      ..moveTo(0, 0)
      ..lineTo(0, max(fromTop - radius, 0))
      ..arcToPoint(Offset(radius, fromTop),
          clockwise: true, radius: Radius.circular(radius))
      ..arcToPoint(Offset(0, fromTop + radius),
          clockwise: true, radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, fromTop + radius)
      ..arcToPoint(Offset(size.width - radius, fromTop),
          clockwise: true, radius: Radius.circular(radius))
      ..arcToPoint(Offset(size.width, max(fromTop - radius, 0)),
          radius: Radius.circular(radius))
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
