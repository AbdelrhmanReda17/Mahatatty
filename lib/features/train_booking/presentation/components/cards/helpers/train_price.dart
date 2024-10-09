import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrainPrice extends StatelessWidget {
  final double trainPrice;
  final double discountTrainPrice;
  final double seatDiscount;
  final bool isShowDiscount;

  const TrainPrice({
    super.key,
    required this.trainPrice,
    required this.discountTrainPrice,
    required this.seatDiscount,
    required this.isShowDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isShowDiscount)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${trainPrice.toStringAsFixed(2)}  ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            RichText(
              text: TextSpan(
                text: isShowDiscount
                    ? ' ${discountTrainPrice.toStringAsFixed(2)}'
                    : ' ${trainPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: ' EGP',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
