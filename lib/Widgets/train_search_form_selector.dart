import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Helpers/train_station_details.dart';

class TrainSearchFormSelector extends StatelessWidget {
  final VoidCallback onSearchClicked;
  final bool isRoundTrip;
  final Function(bool) onRoundTripClicked;
  const TrainSearchFormSelector(
      {super.key,
      required this.onSearchClicked,
      required this.isRoundTrip,
      required this.onRoundTripClicked});

  @override
  Widget build(BuildContext context) {
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TrainStationDetails(
                      code: 'NYC',
                      location: 'New York City',
                      direction: TrainStationDirection.origin,
                      style: TrainStationDetailsStyle.secondary,
                    ),
                    SizedBox(height: 16),
                    TrainStationDetails(
                      code: 'VIT',
                      location: 'Vitoria',
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
                  openDialog(
                    context: context,
                    dialog: const Text('Departure Date'),
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
                      const TextSpan(
                        text: ' 2-5-2022',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isRoundTrip) ...[
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
                    openDialog(
                      context: context,
                      dialog: const Text('Return Date'),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(width: 10)),
                        const TextSpan(
                          text: ' 2-5-2022',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            MahattatyButton(
              onPressed: onSearchClicked,
              style: MahattatyButtonStyle.primary,
              text: 'Search for trains',
            ),
          ],
        ),
      ),
    );
  }
}

// class DateSelector extends StatelessWidget {
//   final String label;
//   final DateTime selectedDate;
//   final ValueChanged<DateTime> onDateSelected;

//   const DateSelector({
//     super.key,
//     required this.label,
//     required this.selectedDate,
//     required this.onDateSelected,
//   });

//   Future<void> _selectDate(BuildContext context) async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null && pickedDate != selectedDate) {
//       onDateSelected(pickedDate);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.grey)),
//         const Spacer(),

//       ],
//     );
//   }

//   String _monthToString(int month) {
//     List<String> months = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December'
//     ];
//     return months[month - 1];
//   }
// }
