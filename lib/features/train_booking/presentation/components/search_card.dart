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
import 'cards/helpers/train_station_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchCardForm extends ConsumerWidget {
  const SearchCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(trainSearchProvider);
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final surface = Theme.of(context).colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ChoiceChip.elevated(
                  label: Text(AppLocalizations.of(context)!.oneWay ,  style: TextStyle(color: searchState.ticketType == TicketType.oneWay ? surface : primaryColor),),
                  selected: searchState.ticketType == TicketType.oneWay,
                  selectedColor: primaryColor,
                  side: BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                  onSelected: (_) =>
                      ref.read(trainSearchProvider.notifier).state =
                          searchState.copyWith(ticketType: TicketType.oneWay),
                ),
                const SizedBox(width: 10),
                ChoiceChip.elevated(
                  label: Text(AppLocalizations.of(context)!.roundTrip ,
                      style: TextStyle(color: searchState.ticketType == TicketType.roundTrip ? surface : primaryColor),),
                  selected: searchState.ticketType == TicketType.roundTrip,
                  selectedColor: primaryColor,
                  side: BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                  onSelected: (_) => ref
                          .read(trainSearchProvider.notifier)
                          .state =
                      searchState.copyWith(ticketType: TicketType.roundTrip),
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
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: AppLocalizations.of(context)!.localeName == 'en'
                      ? 40
                      : null,
                  left: AppLocalizations.of(context)!.localeName == 'ar'
                      ? 40
                      : null,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      searchState.ticketType == TicketType.roundTrip
                          ? FontAwesomeIcons.arrowsUpDown
                          : FontAwesomeIcons.arrowDown,
                      color: surface,
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
                    border: Border.all(color: onPrimaryContainer),
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
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.trainDate}\n',
                            style: TextStyle(
                              color: onPrimaryContainer,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(height: 25)),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              FontAwesomeIcons.solidCalendarDays,
                              color: primaryColor,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          TextSpan(
                            text: " ${TimeConverter.convertTimeToDate(
                              searchState.departureDate,
                              isNumber: true,
                              isDay: true,
                            )} ",
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
                    message: AppLocalizations.of(context)!.sameStationsError,
                    type: MahattatyAlertType.error,
                  );
                  return;
                }
                OpenScreen.openScreenWithSmoothAnimation(
                  context,
                  TrainSearchScreen(
                    key: const Key('train_search'),
                    type: searchState.ticketType,
                  ),
                  false,
                );
              },
              style: MahattatyButtonStyle.primary,
              textStyle: TextStyle(color: surface),
              text: AppLocalizations.of(context)!.searchTrainButton,
            ),
          ],
        ),
      ),
    );
  }
}
