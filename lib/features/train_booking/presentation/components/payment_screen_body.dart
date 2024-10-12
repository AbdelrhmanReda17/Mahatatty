/*import 'package:flutter/material.dart';
import 'package:mahattaty/features/train_booking/presentation/components/payment_details.dart';
import 'package:mahattaty/features/train_booking/presentation/components/payment_method_dialog.dart';
import 'package:mahattaty/features/train_booking/presentation/components/remaining_time_widget.dart';
import '../../../../core/generic components/mahattaty_button.dart';
import '../../domain/entities/ticket.dart';
import 'cards/train_ticket_card.dart';

class PaymentScreenBody extends StatelessWidget {
  final Ticket sampleTicket;
  final String remainingTime;

  const PaymentScreenBody({
    super.key,
    required this.sampleTicket,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          RemainingTimeWidget(remainingTime: remainingTime),
          const SizedBox(height: 20),
          const TrainTicketCard(),
          const SizedBox(height: 20),
          PaymentDetails(ticket: sampleTicket),
          const SizedBox(height: 20),
          MahattatyButton(
            style: MahattatyButtonStyle.primary,
            text: "Pay now",
            onPressed: () => showPaymentDialog(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}*/
