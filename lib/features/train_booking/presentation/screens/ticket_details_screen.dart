import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen(
      {super.key, required this.train, required this.ticket});

  final Train train;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      bgHeight: backgroundHeight.large,
      appBarContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.trainDetails,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TrainCard(
            train: train,
            ticket: ticket,
            ticketType: ticket.type,
            seatType: ticket.seatType,
            departureStation: train.trainDepartureStation,
            arrivalStation: train.trainArrivalStation,
            onTrainSelected: (_, __) {},
            displayTrainTicketCard: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: QrImageView(
                  data: jsonEncode(ticket.toString()),
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
               Text(
                AppLocalizations.of(context)!.scanQr
              ),
            ],
          )
        ],
      ),
    );
  }
}
