import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_circle.dart';
import 'custom_line.dart';

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
                  CustomCircle(
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
                  CustomCircle(
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
