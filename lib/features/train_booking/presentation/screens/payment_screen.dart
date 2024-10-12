import 'package:flutter/material.dart';

import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../domain/entities/ticket.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Ticket sampleTicket = Ticket(
      trainId: '12345',
      userId: 'user_001',
      from: 'Cairo',
      to: 'Alexandria',
      departure: '2024-10-24 08:30:00',
      arrival: '2024-10-24 10:30:00',
      duration: '2 hours',
      price: '25.00',
      type: TicketType.firstClass,
      seatNumber: 'A5',
      status: TicketStatus.booked,
    );

    String remainingTime = getRemainingTime(DateTime.parse(sampleTicket.departure));
    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: const CenterAppBarTitle(),
      bgHeight: backgroundHeight.large,
      body: PaymentScreenBody(sampleTicket: sampleTicket, remainingTime: remainingTime),
    );
  }
}

String getRemainingTime(DateTime departureDateTime) {
  final DateTime now = DateTime.now();
  final Duration difference = departureDateTime.difference(now);

  if (difference.isNegative) {
    return "Departed";
  }

  final int days = difference.inDays;
  final int hours = difference.inHours % 24;
  final int minutes = difference.inMinutes % 60;

  return "$days d $hours h $minutes m";
}

class CenterAppBarTitle extends StatelessWidget {
  const CenterAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Payment',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
