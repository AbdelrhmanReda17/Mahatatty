import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/generic components/mahattaty_button.dart';
import '../../../../core/generic components/mahattaty_switch.dart';
import '../../domain/entities/train.dart';

class SearchCard extends StatelessWidget {
  final VoidCallback onSearchClicked;

  const SearchCard({super.key, required this.onSearchClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TrainStationSelector(
                  direction: TrainStationDirection.origin,
                ),
                Icon(
                  FontAwesomeIcons.rightLeft,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                const TrainStationSelector(
                  direction: TrainStationDirection.destination,
                ),
              ],
            ),
            const SizedBox(height: 12.5),
            Divider(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              thickness: 1,
            ),
            const SizedBox(height: 12.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date of departure',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      'Mon, 10 Sep 2023',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MahattatySwitch(
                      onChanged: (value) {},
                      value: false,
                      enableColor: Theme.of(context).colorScheme.primary,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Round-trip',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total passengers',
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.circleMinus,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 19,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.circlePlus,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: MahattatyButton(
                    onPressed: onSearchClicked,
                    style: MahattatyButtonStyle.primary,
                    text: 'Search for trains',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
              color: Theme.of(context).colorScheme.onPrimaryContainer),
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

class TrainStationSelector extends StatelessWidget {
  final TrainStationDirection direction;

  const TrainStationSelector({
    super.key,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          direction == TrainStationDirection.origin ? 'Departure' : 'Arrival',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 5),
        DropdownMenu(
          width: 150,
          dropdownMenuEntries: TrainStations.allStations.map((station) {
            return DropdownMenuEntry(
              value: station.code,
              label: station.name,
            );
          }).toList(),
        )
      ],
    );
  }
}
