import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';

enum TrainStationDetailsAlignment { start, end }

enum TrainStationDirection { origin, destination }

class TrainStationDetails extends StatelessWidget {
  const TrainStationDetails({
    super.key,
    required this.code,
    required this.location,
    this.alignment = TrainStationDetailsAlignment.start,
    required this.direction,
  });

  final String code;
  final String location;
  final TrainStationDetailsAlignment alignment;
  final TrainStationDirection direction;

  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: onPrimaryContainer),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          text: direction == TrainStationDirection.origin
              ? '${AppLocalizations.of(context)!.departure}\n'
              : '${AppLocalizations.of(context)!.arrival}\n',
          style: TextStyle(color: onPrimaryContainer),
          children: [
            const WidgetSpan(child: SizedBox(height: 25)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                FontAwesomeIcons.locationArrow,
                color: primary
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            TextSpan(
              text: '${AppLocalizations.of(context)!.station(code)}  ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: primary
              ),
            ),
            TextSpan(
              text: code,
              style: TextStyle(
                color: onPrimaryContainer
              ),
            ),
          ],
        ),
      ),
    );
  }
}
