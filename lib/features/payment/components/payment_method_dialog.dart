import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_alert.dart';
import 'package:mahattaty/features/payment/components/payment_method_tile.dart';
import 'package:mahattaty/features/payment/components/show_payment_success_bottom_sheet.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';

import '../../../../core/generic components/mahattaty_dialog.dart';
import '../../train_booking/presentation/controllers/book_ticket_controller.dart';

class PaymentMethodDialog extends ConsumerWidget {
  const PaymentMethodDialog(
      {super.key, required this.ticketId, required this.onClose});

  final String ticketId;
  final String selectedMethod = 'Paypal';
  final Function onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MahattatyDialog(
      title: 'Payment Method',
      description: 'Select a payment method to proceed.',
      content: [
        PaymentMethodTile(
          assetPath: 'images/icons/paypal.png',
          label: 'Paypal',
          detail: 'user****@mail.com',
          isSelected: selectedMethod == 'Paypal',
          onTap: () {
            // setState(() {
            //   selectedMethod = 'Paypal';
            // });
          },
        ),
        const SizedBox(height: 10),
        PaymentMethodTile(
          assetPath: 'images/icons/mastercard.png',
          label: 'Mastercard',
          detail: '1234 56789 1234 ****',
          isSelected: selectedMethod == 'Mastercard',
          onTap: () {
            // setState(() {
            //   selectedMethod = 'Mastercard';
            // });
          },
        ),
        const SizedBox(height: 10),
        PaymentMethodTile(
          assetPath: 'images/icons/vodafone.png',
          label: 'Vodafone Cash',
          detail: '010********',
          isSelected: selectedMethod == 'Vodafone Cash',
          onTap: () {
            // setState(() {
            //   selectedMethod = 'Vodafone Cash';
            // });
          },
        ),
        const SizedBox(height: 10),
        PaymentMethodTile(
          assetPath: 'images/icons/fawry.png',
          label: 'Fawry',
          detail: '',
          isSelected: selectedMethod == 'Fawry',
          onTap: () {
            // setState(() {
            //   selectedMethod = 'Fawry';
            // });
          },
        ),
      ],
      buttonText: 'Confirm Payment',
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () {
        Navigator.of(context).pop();
        ref
            .watch(bookTicketControllerProvider.notifier)
            .changeTrainTicketStatusUseCase(
              ticketId: ticketId,
              status: TicketStatus.booked,
            );
        showPaymentSuccessBottomSheet(
          context,
          onClose,
        );
      },
    );
  }
}
