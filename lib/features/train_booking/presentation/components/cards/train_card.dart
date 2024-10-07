import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';

import '../../../../../core/utils/time_converter.dart';
import '../../../domain/entities/train.dart';
import '../../../domain/entities/train_seat.dart';
import '../count_down_timer.dart';
import 'helpers/custom_line.dart';
import 'helpers/semi_circle_clipper.dart';
import 'helpers/train_price.dart';
import 'helpers/train_time_information.dart';

class TrainCard extends StatelessWidget {
  final Train train;
  final Function(Train) onTrainSelected;
  final bool displayTrainTicketCard;
  final bool isLoading;

  const TrainCard({
    super.key,
    required this.train,
    required this.onTrainSelected,
    this.displayTrainTicketCard = false,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    var trainPrice = train.trainSeats
        .firstWhere((element) => element.seatType == SeatType.business)
        .seatPrice;
    var discountTrainPrice =
        trainPrice - (trainPrice * (train.seatDiscount / 100));
    const String ticketType = "One Way";
    const String ticketClass = "Business";
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ClipPath(
        clipper: SemiCircleClipper(
            fromTop: displayTrainTicketCard ? 245 : 165, radius: 15),
        child: Container(
          margin: !displayTrainTicketCard
              ? const EdgeInsets.only(bottom: 10)
              : const EdgeInsets.only(bottom: 0),
          child: InkWell(
            onTap: () => onTrainSelected(train),
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
                      if (train.seatDiscount > 0) ...[
                        CountdownTimer(
                          targetDateTime: train.seatDiscountDate.toDate(),
                        ),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.trainSubway,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                train.trainName,
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
                            seatDiscount: train.seatDiscount,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                train.trainDepartureStation.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                train.trainDepartureStation.code,
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
                                train.trainArrivalStation.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                train.trainArrivalStation.code,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      const CustomLine(
                        isDashed: true,
                        size: 1,
                        dashWidth: 5,
                        dashSpace: 3,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      TimeInformation(
                        departureTime: train.trainDepartureTime,
                        departureDate: TimeConverter.convertTimeToDate(
                            train.trainArrivalDate),
                        duration: train.trainDuration,
                        arrivalTime: train.trainArrivalTime,
                        arrivalDate: TimeConverter.convertTimeToDate(
                            train.trainArrivalDate),
                      ),
                    ],
                  ),
                ),
                if (displayTrainTicketCard) ...[
                  const TrainTicketCard(
                    ticketType: ticketType,
                    ticketClass: ticketClass,
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
