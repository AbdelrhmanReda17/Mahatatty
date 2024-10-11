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
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const CustomLine(isDashed: true, size: 1, dashWidth: 3, dashSpace: 3),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
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
