import 'package:flutter/material.dart';

import '../../../../core/generic components/mahattaty_empty_data.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import 'cards/train_card.dart';

class UserTicketsDone extends StatelessWidget {
  const UserTicketsDone({super.key, required this.tickets});

  final Map<Ticket, Train> tickets;

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return const MahattatyEmptyData(message: 'No done tickets');
    }
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: TrainCard(
            train: tickets.values.elementAt(index),
            ticketType: tickets.keys.elementAt(index).type,
            seatType: tickets.keys.elementAt(index).seatType,
            departureStation:
                tickets.values.elementAt(index).trainDepartureStation,
            arrivalStation: tickets.values.elementAt(index).trainArrivalStation,
            displayTrainTicketCard: true,
            ticket: tickets.keys.elementAt(index),
          ),
        );
      },
    );
  }
}
