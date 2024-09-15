import 'package:flutter/material.dart';

class MahattatyCircleIcon extends StatelessWidget {
  final Color innerCircleColor;
  final double outerCircleOpacity;
  final Widget child;
  final Color? outerCircleColor;

  // Customizable radius for both outer and inner circles
  final double outerCircleRadius;
  final double innerCircleRadius;

  const MahattatyCircleIcon({
    super.key,
    this.innerCircleColor = const Color(0xff00d261),
    this.outerCircleOpacity = 0.16,
    required this.child,
    this.outerCircleColor,
    this.outerCircleRadius = 78.0,
    this.innerCircleRadius = 55.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer circle with low opacity, defaults to innerCircleColor if not set
        CircleAvatar(
          radius: outerCircleRadius,
          backgroundColor: (outerCircleColor ?? innerCircleColor)
              .withOpacity(outerCircleOpacity),
        ),
        CircleAvatar(
          radius: innerCircleRadius,
          backgroundColor: innerCircleColor,
          child: child,   // This can be an Icon or Stack
        ),
      ],
    );
  }
}
