import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_data_picker.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_train_station_picker.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/search_train_controller.dart';
import 'package:mahattaty/features/train_booking/presentation/screens/train_search_screen.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../../../../core/generic components/mahattaty_button.dart';
import '../../../../core/utils/time_converter.dart';
import '../../domain/entities/ticket.dart';
import '../controllers/get_trains_by_search_controller.dart';
import 'cards/helpers/train_station_details.dart';

class SearchCardForm extends ConsumerWidget {
  const SearchCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(trainSearchProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return ChoiceChip.elevated(
                      label: const Text('One Way'),
                      selected: searchState.ticketType == TicketType.oneWay,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      onSelected: (_) => ref
                              .read(trainSearchProvider.notifier)
                              .state =
                          searchState.copyWith(ticketType: TicketType.oneWay),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Consumer(
                  builder: (context, ref, child) {
                    return ChoiceChip.elevated(
                      label: const Text('Round-trip'),
                      selected: searchState.ticketType == TicketType.roundTrip,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      onSelected: (_) =>
                          ref.read(trainSearchProvider.notifier).state =
                              searchState.copyWith(
                                  ticketType: TicketType.roundTrip),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // From and To Station Picker
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        OpenDialogs.openCustomDialog(
                          context: context,
                          dialog: MahattatyTrainStationPicker(
                            onSelected: (station) {
                              ref.read(trainSearchProvider.notifier).state =
                                  searchState.copyWith(fromStation: station);
                            },
                          ),
                        );
                      },
                      child: TrainStationDetails(
                        code: searchState.fromStation.code,
                        location: searchState.fromStation.name,
                        direction: TrainStationDirection.origin,
                        style: TrainStationDetailsStyle.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        OpenDialogs.openCustomDialog(
                          context: context,
                          dialog: MahattatyTrainStationPicker(
                            onSelected: (station) {
                              ref.read(trainSearchProvider.notifier).state =
                                  searchState.copyWith(toStation: station);
                            },
                          ),
                        );
                      },
                      child: TrainStationDetails(
                        code: searchState.toStation.code,
                        location: searchState.toStation.name,
                        direction: TrainStationDirection.destination,
                        style: TrainStationDetailsStyle.secondary,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 40,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      searchState.ticketType == TicketType.roundTrip
                          ? FontAwesomeIcons.arrowsUpDown
                          : FontAwesomeIcons.arrowDown,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Departure Date Picker
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () async {
                      OpenDialogs.openCustomDialog(
                        context: context,
                        dialog: MahattatyDataPicker(
                          onDateSelected: (DateTime date) {
                            ref.read(trainSearchProvider.notifier).state =
                                searchState.copyWith(
                              departureDate: Timestamp.fromDate(date),
                            );
                          },
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        children: [
                          TextSpan(
                            text: 'Train Date\n',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(height: 25)),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              FontAwesomeIcons.solidCalendarDays,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          TextSpan(
                            text: TimeConverter.convertTimeToDate(
                                searchState.departureDate,
                                isDay: true),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Search Button
            MahattatyButton(
              onPressed: () {
                if (searchState.fromStation == searchState.toStation) {
                  mahattatyAlertDialog(
                    context,
                    message: 'Please select different stations',
                    type: MahattatyAlertType.error,
                  );
                  return;
                }
                OpenScreen.openScreenWithSmoothAnimation(
                  context,
                  const TrainSearchScreen(key: Key('train_search')),
                  false,
                );
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
