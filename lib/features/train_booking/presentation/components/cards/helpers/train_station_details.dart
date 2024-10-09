import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TrainStationDetailsAlignment { start, end }

enum TrainStationDirection { origin, destination }

enum TrainStationDetailsStyle { primary, secondary }

class TrainStationDetails extends StatelessWidget {
  const TrainStationDetails({
    super.key,
    required this.code,
    required this.location,
    this.alignment = TrainStationDetailsAlignment.start,
    this.style = TrainStationDetailsStyle.primary,
    required this.direction,
  });

  final String code;
  final String location;
  final TrainStationDetailsAlignment alignment;
  final TrainStationDetailsStyle style;
  final TrainStationDirection direction;

  @override
  Widget build(BuildContext context) {
    var primaryContent = Column(
      crossAxisAlignment: alignment == TrainStationDetailsAlignment.start
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          direction == TrainStationDirection.origin
              ? style == TrainStationDetailsStyle.primary
                  ? 'Departure'
                  : 'From'
              : style == TrainStationDetailsStyle.primary
                  ? 'Arrival'
                  : 'To',
          style: const TextStyle(color: Colors.blue),
        ),
        const SizedBox(height: 5),
        Text(
          code,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Text(
          location,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );

    var secondaryContent = Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          text: 'From\n',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          children: [
            const WidgetSpan(child: SizedBox(height: 25)),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                FontAwesomeIcons.locationArrow,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            TextSpan(
              text: location,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            TextSpan(
              text: code,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );

    return style == TrainStationDetailsStyle.primary
        ? primaryContent
        : secondaryContent;
  }
}
