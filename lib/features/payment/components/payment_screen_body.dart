import 'package:flutter/material.dart';
import 'package:mahattaty/features/payment/components/payment_details.dart';
import 'package:mahattaty/features/payment/components/payment_method_dialog.dart';
import 'package:mahattaty/features/payment/components/remaining_time_widget.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/domain/entities/train.dart';
import '../../train_booking/presentation/components/cards/train_card.dart';
import '../../train_booking/presentation/components/cards/train_ticket_card.dart';

class PaymentScreenBody extends StatelessWidget {
  final Ticket sampleTicket;
  final String remainingTime;
  final Train sampleTrain;

  const PaymentScreenBody({
    super.key,
    required this.sampleTicket,
    required this.remainingTime,
    required this.sampleTrain,
  });

  @override
  Widget build(BuildContext context) {
    // Debugging output to check the values
    print('Sample Train: ${sampleTrain.toString()}');
    print('Sample Ticket: ${sampleTicket.toString()}');

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          RemainingTimeWidget(remainingTime: remainingTime),
          const SizedBox(height: 20),
          TrainCard(
            train: sampleTrain,
            ticket: sampleTicket,
            ticketType: sampleTicket.type,
            seatType: sampleTicket.seatType,
            departureStation: sampleTrain.trainDepartureStation,
            arrivalStation: sampleTrain.trainArrivalStation,
            displayTrainTicketCard: true,
            // onTrainSelected: (ticket, train) => showPaymentDialog(context),
          ),
          const SizedBox(height: 20),
          // PaymentDetails(ticket: sampleTicket, train: sampleTrain),
          const SizedBox(height: 20),
          // MahattatyButton(
          //   style: MahattatyButtonStyle.primary,
          //   text: "Pay now",
          //   // onPressed: () => showPaymentDialog(context),
          //   backgroundColor: Theme
          //       .of(context)
          //       .colorScheme
          //       .primary,
          //   textStyle: const TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
