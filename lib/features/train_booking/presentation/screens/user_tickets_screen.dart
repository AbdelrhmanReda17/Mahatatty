import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_data_picker.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_error.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_loading.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../components/user_tickets_tabs_controller.dart';
import '../controllers/get_user_booked_trains_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserTicketsScreen extends ConsumerStatefulWidget {
  const UserTicketsScreen({super.key});

  @override
  UserTicketsScreenState createState() => UserTicketsScreenState();
}

class UserTicketsScreenState extends ConsumerState<UserTicketsScreen> {
  DateTime? filterDate;
  int filterTrainType = 0;

  @override
  Widget build(BuildContext context) {
    final userTickets = ref.watch(getUserBookedTrainsController);
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                AppLocalizations.of(context)!.myTickets,
                style: TextStyle(color: surfaceColor, fontWeight: FontWeight.w600),
                           ),
             ),
            IconButton(
              onPressed: () {
                OpenDialogs.openCustomDialog(
                  context: context,
                  dialog: MahattatyDataPicker(
                    onDateSelected: (date) {
                      setState(() {
                        filterDate = date;
                      });
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: Column(
        children: [
          FilterWidget(
            selectedValue: filterTrainType,
            onSelected: (val) {
              setState(() {
                filterTrainType = val!;
              });
            },
          ),
          userTickets.when(
            data: (tickets) => Expanded(
              child: UserTicketsTabsController(
                tickets: tickets,
                filterDate: filterDate,
                filterTrainType: filterTrainType,
              ),
            ),
            loading: () => const Expanded(child: MahattatyLoading()),
            error: (error, _) => Expanded(
              child: MahattatyError(
                onRetry: () => ref.refresh(getUserBookedTrainsController),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final int? selectedValue;
  final ValueChanged<int?> onSelected;

  const FilterWidget({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> filters = [
      AppLocalizations.of(context)!.all,
      for (final TrainType status in TrainType.values) AppLocalizations.of(context)!.train(status),
    ];
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.085,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = selectedValue == index;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              showCheckmark: false,
              backgroundColor: primaryColor,
              selectedColor: Colors.white,
              disabledColor: Colors.white,
              labelStyle: isSelected
                  ? TextStyle(
                      color: primaryColor,
                      fontSize: 17,
                    )
                  : TextStyle(color: surfaceColor),
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onSelected(
                    index,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
