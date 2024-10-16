import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import 'custom_circle.dart';
import 'custom_line.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;


    Widget buildDateComponent(String time ,String date ,TextAlign textAlign , CrossAxisAlignment crossAxisAlignment){
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              AppLocalizations.of(context)!.arabicOrEnglish(time),
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              textAlign: textAlign,
              AppLocalizations.of(context)!.arabicOrEnglish(date),
              style: TextStyle(
                color: onPrimaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDateComponent(departureTime, departureDate ,TextAlign.left ,CrossAxisAlignment.start),
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
                  CustomLine(size: MediaQuery.of(context).size.width * 0.08),
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
                  CustomLine(size: MediaQuery.of(context).size.width * 0.08),
                  CustomCircle(
                    radius: 6,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${AppLocalizations.of(context)!.duration} $duration',
                style: TextStyle(
                  color: onPrimaryContainer,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        // Arrival Time
        buildDateComponent(arrivalTime, arrivalDate ,TextAlign.right ,CrossAxisAlignment.end),
      ],
    );
  }
}
