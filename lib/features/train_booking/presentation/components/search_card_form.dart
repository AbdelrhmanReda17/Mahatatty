import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_data_picker.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/generic components/mahattaty_button.dart';
import '../../../../core/utils/time_converter.dart';
import '../controllers/search_train_controller.dart';

class SearchCardForm extends ConsumerWidget {
  final VoidCallback switchForms;
  final bool isRoundTrip;
  final Function(bool) onRoundTripClicked;
  final VoidCallback onSearchClicked;

  const SearchCardForm({
    super.key,
    required this.switchForms,
    required this.isRoundTrip,
    required this.onRoundTripClicked,
    required this.onSearchClicked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);
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
                ChoiceChip.elevated(
                  label: const Text('One Way'),
                  selected: !isRoundTrip,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  onSelected: (_) => onRoundTripClicked(false),
                ),
                const SizedBox(width: 10),
                ChoiceChip.elevated(
                  label: const Text('Round-trip'),
                  selected: isRoundTrip,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  onSelected: (_) => onRoundTripClicked(true),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TrainStationDetails(
                      code: searchQuery.fromStation!.code,
                      location: searchQuery.fromStation!.name,
                      direction: TrainStationDirection.origin,
                      style: TrainStationDetailsStyle.secondary,
                    ),
                    const SizedBox(height: 16),
                    TrainStationDetails(
                      code: searchQuery.toStation!.code,
                      location: searchQuery.toStation!.name,
                      direction: TrainStationDirection.destination,
                      style: TrainStationDetailsStyle.secondary,
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
                      isRoundTrip
                          ? FontAwesomeIcons.arrowsUpDown
                          : FontAwesomeIcons.arrowDown,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
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
                        ref.read(searchProvider.notifier).state =
                            ref.read(searchProvider).copyWith(
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                            searchQuery.departureDate),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: isRoundTrip
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () async {
                              OpenDialogs.openCustomDialog(
                                context: context,
                                dialog: MahattatyDataPicker(
                                  onDateSelected: (DateTime date) {
                                    ref.read(searchProvider.notifier).state =
                                        ref.read(searchProvider).copyWith(
                                              arrivalDate:
                                                  Timestamp.fromDate(date),
                                            );
                                  },
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                children: [
                                  TextSpan(
                                    text: 'Return Date\n',
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                    text: TimeConverter.convertTimeToDate(
                                        searchQuery.arrivalDate),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 16),
            MahattatyButton(
              onPressed: () {
                onSearchClicked();
                // switchForms();
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
