import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_data_picker.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_error.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_loading.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../components/my_ticket_filter.dart';
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
                style:
                    TextStyle(color: surfaceColor, fontWeight: FontWeight.w600),
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
              icon: Icon(
                Icons.calendar_today,
                color: surfaceColor,
              ),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(getUserBookedTrainsController);
        },
        child: Column(
          children: [
            MyTicketsFilter(
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
      ),
    );
  }
}
