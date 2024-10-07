import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';

import '../../../../../core/utils/time_converter.dart';
import '../../../domain/entities/train.dart';
import '../../../domain/entities/train_seat.dart';
import '../count_down_timer.dart';

class TrainCard extends StatelessWidget {
  final Train train;
  final Function(Train) onTrainSelected;
  final bool displayTrainTicketCard;

  const TrainCard(
      {super.key,
      required this.train,
      required this.onTrainSelected,
      this.displayTrainTicketCard = false});

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
            fromTop: displayTrainTicketCard ? 245 : 155, radius: 15),
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
                          TrainPriceDisplay(
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
                      DashedDivider(
                        height: 1,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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

class TrainPriceDisplay extends StatelessWidget {
  final double trainPrice;
  final double discountTrainPrice;
  final double seatDiscount;

  const TrainPriceDisplay({
    super.key,
    required this.trainPrice,
    required this.discountTrainPrice,
    required this.seatDiscount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (seatDiscount > 0)
              Text(
                trainPrice.toStringAsFixed(2),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                ),
              ),
            RichText(
              text: TextSpan(
                text: discountTrainPrice.toStringAsFixed(2),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: ' EGP',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrainTicketCard extends StatelessWidget {
  const TrainTicketCard(
      {super.key, required this.ticketType, required this.ticketClass});

  final String ticketType;
  final String ticketClass;

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
          DashedDivider(
            height: 1,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            dashWidth: 5,
            dashSpace: 3,
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
                            text: ticketType,
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
                            text: ticketClass,
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

class SemiCircleClipper extends CustomClipper<Path> {
  SemiCircleClipper({
    required this.fromTop,
    required this.radius,
  });

  final double fromTop;
  final double radius;

  @override
  Path getClip(Size size) {
    var path = Path();
    path
      ..moveTo(0, 0)
      ..lineTo(0, max(fromTop - radius, 0))
      ..arcToPoint(Offset(radius, fromTop),
          clockwise: true, radius: Radius.circular(radius))
      ..arcToPoint(Offset(0, fromTop + radius),
          clockwise: true, radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, fromTop + radius)
      ..arcToPoint(Offset(size.width - radius, fromTop),
          clockwise: true, radius: Radius.circular(radius))
      ..arcToPoint(Offset(size.width, max(fromTop - radius, 0)),
          radius: Radius.circular(radius))
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.black,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
