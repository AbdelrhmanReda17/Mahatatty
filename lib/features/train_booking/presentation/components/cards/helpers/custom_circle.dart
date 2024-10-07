import 'package:flutter/material.dart';

class CustomCircle extends StatelessWidget {
  const CustomCircle({super.key, required this.radius, required this.color});

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
