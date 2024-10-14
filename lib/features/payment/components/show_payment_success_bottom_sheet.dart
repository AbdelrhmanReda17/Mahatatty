import 'package:flutter/material.dart';
import 'package:mahattaty/Themes/light_theme.dart';
import '../../../core/generic components/mahattaty_button.dart';
import 'mahattaty_circle_icon.dart';

void showPaymentSuccessBottomSheet(BuildContext context, Function onClose) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: MahattatyCircleIcon(
                outerCircleRadius: 70.0,
                innerCircleRadius: 50.0,
                child: Icon(
                  Icons.credit_card_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Payment Successful',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your ticket for the journey has been successful. Thank you!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: customGrey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            MahattatyButton(
              text: 'Close',
              style: MahattatyButtonStyle.primary,
              onPressed: () {
                Navigator.of(context).pop();
                onClose();
              },
              height: 60,
              width: double.infinity,
            ),
          ],
        ),
      );
    },
  );
}
