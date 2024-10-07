import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({
    super.key,
    required this.size,
    this.vertical = false,
    this.isDashed = false,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  final bool vertical;
  final double size;
  final bool isDashed;
  final double dashWidth;
  final double dashSpace;

  @override
  Widget build(BuildContext context) {
    return isDashed
        ? SizedBox(
            height: size,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final boxWidth = constraints.constrainWidth();
                final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: size,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      ),
                    );
                  }),
                );
              },
            ),
          )
        : Container(
            height: vertical ? size : 1,
            width: vertical ? 1 : size,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
          );
  }
}
