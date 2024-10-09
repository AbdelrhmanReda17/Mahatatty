import 'package:flutter/material.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/helpers/custom_line.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';

class TrainTicketCard extends StatelessWidget {
  const TrainTicketCard(
      {super.key, required this.ticketType, required this.seatType});

  final TicketType ticketType;
  final SeatType seatType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          const CustomLine(
            isDashed: true,
            dashWidth: 3,
            dashSpace: 3,
            size: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Type\n',
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ticketType.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const CustomLine(
                  size: 30,
                  vertical: true,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Class\n',
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: seatType.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
