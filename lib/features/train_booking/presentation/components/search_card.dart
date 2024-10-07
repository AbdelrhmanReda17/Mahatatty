import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../../../../core/generic components/mahattaty_button.dart';
import '../../../../core/generic components/mahattaty_switch.dart';
import '../../domain/entities/train.dart';
import '../controllers/search_train_controller.dart';

class SearchCard extends ConsumerWidget {
  final VoidCallback switchForms;

  const SearchCard({super.key, required this.switchForms});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);
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
                TrainStationSelector(
                  direction: TrainStationDirection.origin,
                  onSelected: (station) {
                    ref.read(searchProvider).fromStation = station!;
                  },
                ),
                Icon(
                  FontAwesomeIcons.rightLeft,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                TrainStationSelector(
                  direction: TrainStationDirection.destination,
                  onSelected: (station) {
                    ref.read(searchProvider).toStation = station!;
                  },
                ),
              ],
            ),
            const SizedBox(height: 12.5),
            MahattatyButton(
              onPressed: () {
                log('Search for trains');
                log(searchQuery.fromStation.toString());
                log(searchQuery.toStation.toString());
                if (searchQuery.fromStation != null &&
                    searchQuery.toStation != null &&
                    searchQuery.fromStation != searchQuery.toStation) {
                  switchForms();
                } else {
                  mahattatyAlertDialog(
                    context,
                    message: searchQuery.fromStation != null &&
                            searchQuery.toStation != null
                        ? 'Please select both departure and arrival stations'
                        : 'Departure and arrival stations cannot be the same',
                    type: MahattatyAlertType.error,
                  );
                }
              },
              style: MahattatyButtonStyle.primary,
              text: 'Search for trains',
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

class TrainStationSelector extends StatelessWidget {
  final TrainStationDirection direction;
  final Function(TrainStations? station) onSelected;

  const TrainStationSelector({
    super.key,
    required this.direction,
    required this.onSelected,
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
          onSelected: (value) {
            if (value != null) onSelected(value);
          },
          width: 150,
          dropdownMenuEntries: TrainStations.allStations.map((station) {
            return DropdownMenuEntry<TrainStations>(
              value: station,
              label: station.name,
            );
          }).toList(),
        )
      ],
    );
  }
}
