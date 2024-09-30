import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrainTicketCard extends StatelessWidget {
  const TrainTicketCard({super.key});
  final String trainName = "Pensitanian Train";
  final String departureCity = "New York City";
  final String departureCityCode = "NYC";
  final String destinationCity = "Pennsylvania";
  final String destinationCityCode = "PNV";
  final String departureTime = "08:30 AM";
  final String departureDate = "24 Feb 2023";
  final String duration = "1h 15m";
  final String arrivalTime = "10:00 AM";
  final String arrivalDate = "24 Feb 2023";

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                      trainName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departureCity,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    Text(
                      departureCityCode,
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
                      destinationCity,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    Text(
                      destinationCityCode,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
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
            // Time Information
            TimeInformation(
              departureTime: departureTime,
              departureDate: departureDate,
              duration: duration,
              arrivalTime: arrivalTime,
            ),
          ],
        ),
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
  });

  final String departureTime;
  final String departureDate;
  final String duration;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Departure Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              departureTime,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              departureDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),

        // Dashed Line with Train Icon in the Center
        Column(
          children: [
            Row(
              children: [
                Circle(
                  radius: 6,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const CustomLine(width: 50),
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
                const CustomLine(width: 50), // Custom dashed line widget
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

        // Arrival Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              arrivalTime,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              departureDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: width,
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
