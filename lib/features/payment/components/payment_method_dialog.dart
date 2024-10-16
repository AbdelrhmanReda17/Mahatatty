import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/payment/components/payment_method_tile.dart';
import 'package:mahattaty/features/payment/components/show_payment_success_bottom_sheet.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import '../../train_booking/presentation/controllers/book_ticket_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodDialog extends ConsumerStatefulWidget {
  const PaymentMethodDialog(
      {super.key, required this.ticketId, required this.onClose});

  final String ticketId;
  final Function onClose;

  @override
  PaymentMethodDialogState createState() => PaymentMethodDialogState();
}
class PaymentMethodDialogState extends ConsumerState<PaymentMethodDialog> {
  String selectedMethod = 'Paypal';

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(bookTicketControllerProvider);
    return MahattatyDialog(
      title: AppLocalizations.of(context)!.paymentMethod,
      description: AppLocalizations.of(context)!.paymentMethodDescription,
      content: [
        PaymentMethodTile(
          assetPath: 'images/icons/paypal.png',
          label: AppLocalizations.of(context)!.paypal,
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
          assetPath: 'images/icons/mastercard.png',
          label: AppLocalizations.of(context)!.masterCard,
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
          assetPath: 'images/icons/vodafone.png',
          label: AppLocalizations.of(context)!.vodafoneCash,
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
          assetPath: 'images/icons/fawry.png',
          label: AppLocalizations.of(context)!.fawry,
          detail: '',
          isSelected: selectedMethod == 'Fawry',
          onTap: () {
            setState(() {
              selectedMethod = 'Fawry';
            });
          },
        ),
      ],
      buttonText: AppLocalizations.of(context)!.paySuccess,
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () async {
        Navigator.of(context).pop();
        await ref
            .watch(bookTicketControllerProvider.notifier)
            .changeTicketStatus(
             widget.ticketId,
               TicketStatus.booked,
            );
        if(paymentState.error != null) {
          return;
        }
        showPaymentSuccessBottomSheet(
          context,
          widget.onClose,
        );
      },
    );
  }
}
