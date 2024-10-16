import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';

class TrainPrice extends StatelessWidget {
  final double trainPrice;
  final double discountTrainPrice;
  final bool isShowDiscount;

  const TrainPrice({
    super.key,
    required this.trainPrice,
    required this.discountTrainPrice,
    required this.isShowDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

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
                  text : ' ${AppLocalizations.of(context)!.arabicOrEnglish(trainPrice.toStringAsFixed(2))} ',
                  style: TextStyle(
                    color: onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            RichText(
              text: TextSpan(
                text: isShowDiscount
            ? AppLocalizations.of(context)!.arabicOrEnglish(discountTrainPrice.toStringAsFixed(2))
                    : AppLocalizations.of(context)!.arabicOrEnglish(trainPrice.toStringAsFixed(2)),
                style: TextStyle(
                  color: onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.egp,
                    style: TextStyle(
                      color: onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
