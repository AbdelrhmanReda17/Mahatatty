import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_scaffold.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/domain/entities/train.dart';
import '../../train_booking/domain/entities/train_seat.dart';
import '../../train_booking/presentation/components/cards/train_card.dart';
import '../../train_booking/presentation/controllers/book_ticket_controller.dart';
import '../components/count_down_timer.dart';
import '../components/payment_method_dialog.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final Train train;
  final TicketType ticketType;
  final SeatType seatType;
  final String ticketId;

  const PaymentScreen({
    super.key,
    required this.train,
    required this.ticketType,
    required this.seatType,
    required this.ticketId,
  });

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool isDialog = false;

  void handleDialog() {
    setState(() {
      isDialog = !isDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      onWillPop: () async {
        await ref.watch(bookTicketControllerProvider.notifier).cancelTicket(
              widget.ticketId,
            );
      },
      appBarContent: const Text(
        'Payment',
        style: TextStyle(color: Colors.white),
      ),
      bgHeight: backgroundHeight.large,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Ticket ID: ${widget.ticketId}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your ticket on hold for 10 seconds please pay now to confirm your ticket',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CountdownTimer(
              onTimerEnd: () => {
                ref.watch(bookTicketControllerProvider.notifier).cancelTicket(
                      widget.ticketId,
                    ),
                Navigator.of(context).popUntil(
                  (route) {
                    return route.settings.name ==
                        const RootScreen().homeRouteName;
                  },
                ),
              },
              targetDateTime: DateTime.now().add(const Duration(seconds: 10)),
            ),
            const SizedBox(height: 20),
            TrainCard(
              train: widget.train,
              ticketType: widget.ticketType,
              seatType: widget.seatType,
              departureStation: widget.train.trainDepartureStation,
              arrivalStation: widget.train.trainArrivalStation,
              displayTrainTicketCard: true,
            ),
            const SizedBox(height: 20),
            MahattatyButton(
              style: MahattatyButtonStyle.primary,
              text: "Pay now",
              onPressed: () {
                handleDialog();
                OpenDialogs.openCustomDialog(
                  context: context,
                  dialog: PaymentMethodDialog(
                    ticketId: widget.ticketId,
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
