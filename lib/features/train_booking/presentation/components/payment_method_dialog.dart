/*import 'package:flutter/material.dart';
import 'package:mahattaty/features/train_booking/presentation/components/payment_method_tile.dart';

import '../../../../core/generic components/mahattaty_dialog.dart';


void showPaymentDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Color(0xFFf5f5f5),
    builder: (BuildContext context) {
      String selectedMethod = 'Mastercard';

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: MahattatyDialog(
              title: 'Payment Method',
              description: 'Select a payment method to proceed.',
              content: [
                PaymentMethodTile(
                  assetPath: paypalIcon,
                  label: 'Paypal',
                  detail: 'user****@mail.com',
                  isSelected: selectedMethod == 'Paypal',
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Paypal';
                    });
                  },
                ),
                const SizedBox(height: 10),
                PaymentMethodTile(
                  assetPath: mastercardIcon,
                  label: 'Mastercard',
                  detail: '1234 56789 1234 ****',
                  isSelected: selectedMethod == 'Mastercard',
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Mastercard';
                    });
                  },
                ),
                const SizedBox(height: 10),
                PaymentMethodTile(
                  assetPath: vodafoneIcon,
                  label: 'Vodafone Cash',
                  detail: '010********',
                  isSelected: selectedMethod == 'Vodafone Cash',
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Vodafone Cash';
                    });
                  },
                ),
                const SizedBox(height: 10),
                PaymentMethodTile(
                  assetPath: fawryIcon,
                  label: 'Fawry',
                  detail: '',
                  isSelected: selectedMethod == 'Fawry',
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Fawry';
                    });
                  },
                ),
              ],
              buttonText: 'Confirm Payment',
              contentPlacement: ContentPlacement.afterTitle,
              onButtonPressed: () {
                Navigator.of(context).pop();
                showPaymentSuccessBottomSheet(context);
              },
            ),
          );
        },
      );
    },
  );
}*/
