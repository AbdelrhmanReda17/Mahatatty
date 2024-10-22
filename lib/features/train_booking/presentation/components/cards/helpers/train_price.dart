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
    final primary = Theme.of(context).colorScheme.primary;
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isShowDiscount && trainPrice != discountTrainPrice)
 RichText(
                     textAlign: TextAlign.end,

                     maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text : AppLocalizations.of(context)!.arabicOrEnglish(trainPrice.toStringAsFixed(2)),
                      style: TextStyle(
                        color: primary,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                                   ),
            RichText(
                   textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: isShowDiscount
                               ? ' ${AppLocalizations.of(context)!.arabicOrEnglish(discountTrainPrice.toStringAsFixed(2))}'
                        : ' ${AppLocalizations.of(context)!.arabicOrEnglish(trainPrice.toStringAsFixed(2))}',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: ' ${AppLocalizations.of(context)!.egp}',
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
