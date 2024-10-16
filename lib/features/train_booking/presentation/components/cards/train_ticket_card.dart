import 'package:flutter/material.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/helpers/custom_line.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainTicketCard extends StatelessWidget {
  const TrainTicketCard(
      {super.key, required this.ticketType, required this.seatType});

  final TicketType ticketType;
  final SeatType seatType;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: surfaceColor,
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
                        text: '${AppLocalizations.of(context)!.ticketType}\n',
                        style: TextStyle(
                          color:
                          onPrimaryContainerColor,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.ticket(ticketType),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primaryColor,
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
                        text: '${AppLocalizations.of(context)!.ticketClass}\n',
                        style: TextStyle(
                          color: onPrimaryContainerColor,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.seat(seatType),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primaryColor,
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
