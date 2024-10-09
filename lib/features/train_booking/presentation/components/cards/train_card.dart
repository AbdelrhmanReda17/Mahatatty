import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';

import '../../../../../core/utils/time_converter.dart';
import '../../../domain/entities/ticket.dart';
import '../../../domain/entities/train.dart';
import '../../../domain/entities/train_seat.dart';
import '../count_down_timer.dart';
import 'helpers/custom_line.dart';
import 'helpers/semi_circle_clipper.dart';
import 'helpers/train_price.dart';
import 'helpers/train_time_information.dart';

class TrainCard extends StatelessWidget {
  final Train? train;
  final TicketType? ticketType;
  final SeatType? seatType;
  final TrainStations departureStation;
  final TrainStations arrivalStation;

  final Function(Train)? onTrainSelected;
  final bool displayTrainTicketCard;
  final bool isLoading;

  const TrainCard({
    super.key,
    this.train,
    this.ticketType,
    this.seatType,
    this.onTrainSelected,
    required this.departureStation,
    required this.arrivalStation,
    this.displayTrainTicketCard = false,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    var trainPrice = 0.0, discountTrainPrice = 0.0, isShowDiscount = false;
    if (train != null) {
      trainPrice = train!.trainSeats
          .firstWhere((element) => element.seatType == SeatType.business)
          .seatPrice;
      discountTrainPrice =
          trainPrice - (trainPrice * (train!.seatDiscount / 100));

      isShowDiscount = train!.seatDiscount != 0 &&
          train!.seatDiscountDate.toDate().isAfter(DateTime.now());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ClipPath(
        clipper: SemiCircleClipper(
            fromTop: displayTrainTicketCard && train != null
                ? 245
                : train != null && !isShowDiscount
                    ? 120
                    : train != null && isShowDiscount
                        ? 165
                        : 90,
            radius: 15),
        child: Container(
          margin: !displayTrainTicketCard
              ? const EdgeInsets.only(bottom: 10)
              : const EdgeInsets.only(bottom: 0),
          child: InkWell(
            onTap:
                onTrainSelected != null ? () => onTrainSelected!(train!) : null,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (train != null && isShowDiscount) ...[
                        CountdownTimer(
                          targetDateTime: train!.seatDiscountDate.toDate(),
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (train != null) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.trainSubway,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  train!.trainName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            TrainPrice(
                              trainPrice: trainPrice,
                              discountTrainPrice: discountTrainPrice,
                              seatDiscount: train!.seatDiscount,
                              isShowDiscount: isShowDiscount,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                departureStation.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                departureStation.code,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                arrivalStation.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                arrivalStation.code,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      if (train != null) ...[
                        const CustomLine(
                          isDashed: true,
                          size: 1,
                          dashWidth: 3,
                          dashSpace: 3,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015),
                        TimeInformation(
                          departureTime: train!.trainDepartureTime,
                          departureDate: TimeConverter.convertTimeToDate(
                              train!.trainArrivalDate),
                          duration: train!.trainDuration,
                          arrivalTime: train!.trainArrivalTime,
                          arrivalDate: TimeConverter.convertTimeToDate(
                            train!.trainArrivalDate,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                if (ticketType != null &&
                    seatType != null &&
                    displayTrainTicketCard) ...[
                  TrainTicketCard(
                    ticketType: ticketType!,
                    seatType: seatType!,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
