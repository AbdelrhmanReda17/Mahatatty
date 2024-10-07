import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/utils/time_converter.dart';

import '../../../domain/entities/train.dart';
import '../../../domain/entities/train_seat.dart';
import '../count_down_timer.dart';

class TrainTicketCard extends StatelessWidget {
  const TrainTicketCard(
      {super.key, this.displayTicketDetails = false, required this.train});

  final Train train;

  final String ticketType = "One Way";
  final String ticketClass = "Business";

  final bool displayTicketDetails;

  @override
  Widget build(BuildContext context) {
    var trainPrice = train.trainSeats
        .firstWhere((element) => element.seatType == SeatType.business)
        .seatPrice;
    var discountTrainPrice =
        trainPrice - (trainPrice * (train.seatDiscount / 100));
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Card(
            margin: !displayTicketDetails
                ? const EdgeInsets.only(bottom: 10)
                : const EdgeInsets.only(bottom: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (train.seatDiscount > 0)
                    CountdownTimer(
                      targetDateTime: train.seatDiscountDate.toDate(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.trainSubway,
                            color: Theme.of(context).colorScheme.primary,
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
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\nEGP \n',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            if (train.seatDiscount > 0)
                              TextSpan(
                                text: '${trainPrice.toStringAsFixed(2)} ',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                ),
                              ),
                            TextSpan(
                              text: '${discountTrainPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                  .onPrimaryContainer,
                            ),
                          ),
                          Text(
                            train.trainArrivalStation.code,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(height: 16),
                  TimeInformation(
                    departureTime: train.trainDepartureTime,
                    departureDate:
                        TimeConverter.convertTimeToDate(train.trainArrivalDate),
                    duration: train.trainDuration,
                    arrivalTime: train.trainArrivalTime,
                    arrivalDate:
                        TimeConverter.convertTimeToDate(train.trainArrivalDate),
                  ),
                ],
              ),
            ),
          ),
          if (displayTicketDetails)
            Card(
              margin: const EdgeInsets.only(top: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: ticketType,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: ticketClass,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
            ),
        ],
      ),
    );
  }
}

class TimeInformation extends StatelessWidget {
  const TimeInformation({
    super.key,
    required this.departureTime,
    required this.departureDate,
    required this.duration,
    required this.arrivalTime,
    required this.arrivalDate,
  });

  final String departureTime;
  final String departureDate;
  final String arrivalDate;
  final String duration;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                departureTime,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                departureDate,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Circle(
                    radius: 6,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const CustomLine(size: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(FontAwesomeIcons.trainSubway,
                          color: Colors.white),
                    ),
                  ),
                  const CustomLine(size: 40),
                  Circle(
                    radius: 6,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Duration: $duration',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        // Arrival Time
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                arrivalTime,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                textAlign: TextAlign.right,
                arrivalDate,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key, required this.size, this.vertical = false});

  final bool vertical;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: vertical ? size : 1,
      width: vertical ? 1 : size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key, required this.radius, required this.color});

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
