import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_data_picker.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_search.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train.dart';
import 'package:mahattaty/features/train_booking/presentation/screens/ticket_details_screen.dart';

import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../../../core/utils/open_screens.dart';
import '../../domain/entities/ticket.dart';
import '../components/cards/train_card.dart';
import '../controllers/get_user_booked_trains_controller.dart';

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
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Ticket',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
              child: MyTicketsTabsController(
                tickets: tickets,
                filterDate: filterDate,
                filterTrainType: filterTrainType,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Error While Fetching Trains, Please Try Again !!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(getUserBookedTrainsController);
                  },
                  child: const Text('Retry'),
                ),
              ],
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
      'All',
      for (final TrainType status in TrainType.values) status.name
    ];

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
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedColor: Colors.white,
              disabledColor: Colors.white,
              labelStyle: isSelected
                  ? TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17,
                    )
                  : TextStyle(color: Theme.of(context).colorScheme.surface),
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onSelected(
                      index); // Notify the parent about the selected index
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class MyTicketsTabsController extends StatelessWidget {
  const MyTicketsTabsController({
    super.key,
    required this.tickets,
    required this.filterDate,
    required this.filterTrainType,
  });

  final Map<Ticket, Train> tickets;
  final DateTime? filterDate;
  final int filterTrainType;

  @override
  Widget build(BuildContext context) {
    final Map<Ticket, Train> upComingTickets = Map.fromEntries(
      tickets.entries.where(
        (entry) {
          final train = entry.value;
          bool dateMatches = filterDate == null ||
              train.trainDepartureDate.toDate().isAfter(filterDate!);
          bool typeMatches = filterTrainType == 0 ||
              train.trainType.index == filterTrainType - 1;
          return train.trainDepartureDate.toDate().isAfter(DateTime.now()) &&
              dateMatches &&
              typeMatches;
        },
      ),
    );

    final Map<Ticket, Train> doneTickets = Map.fromEntries(
      tickets.entries.where(
        (entry) {
          final train = entry.value;
          bool dateMatches = filterDate == null ||
              train.trainDepartureDate.toDate().isAfter(filterDate!);
          bool typeMatches = filterTrainType == 0 ||
              train.trainType.index == filterTrainType - 1;
          return train.trainDepartureDate.toDate().isBefore(DateTime.now()) &&
              dateMatches &&
              typeMatches;
        },
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TabBar(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              isScrollable: false,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              tabs: const [
                Tab(text: 'Up Coming'),
                Tab(text: 'Done'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  MyTicketUpComingScreen(tickets: upComingTickets),
                  MyTicketDoneScreen(tickets: doneTickets),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTicketDoneScreen extends StatelessWidget {
  const MyTicketDoneScreen({super.key, required this.tickets});

  final Map<Ticket, Train> tickets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (BuildContext context, int index) {
        return TrainCard(
          train: tickets.values.elementAt(index),
          ticketType: tickets.keys.elementAt(index).type,
          seatType: tickets.keys.elementAt(index).seatType,
          departureStation:
              tickets.values.elementAt(index).trainDepartureStation,
          arrivalStation: tickets.values.elementAt(index).trainArrivalStation,
          displayTrainTicketCard: true,
          ticket: tickets.keys.elementAt(index),
        );
      },
    );
  }
}

class MyTicketUpComingScreen extends StatelessWidget {
  const MyTicketUpComingScreen({super.key, required this.tickets});

  final Map<Ticket, Train> tickets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (BuildContext context, int index) {
        return TrainCard(
          train: tickets.values.elementAt(index),
          ticketType: tickets.keys.elementAt(index).type,
          seatType: tickets.keys.elementAt(index).seatType,
          departureStation:
              tickets.values.elementAt(index).trainDepartureStation,
          arrivalStation: tickets.values.elementAt(index).trainArrivalStation,
          displayTrainTicketCard: true,
          ticket: tickets.keys.elementAt(index),
          onTrainSelected: (ticket, train) {
            OpenScreen.openScreenWithSmoothAnimation(
              context,
              TicketDetailScreen(
                ticket: ticket!,
                train: train!,
              ),
              false,
            );
          },
        );
      },
    );
  }
}
