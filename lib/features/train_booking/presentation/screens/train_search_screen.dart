import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/Dialogs/mahattaty_train_filter_dialog.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';

import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../domain/entities/train_seat.dart';
import '../components/cards/train_card.dart';
import '../components/date_list.dart';
import '../controllers/get_trains_by_search_controller.dart';
import '../controllers/search_train_controller.dart';

class TrainSearchScreen extends ConsumerWidget {
  const TrainSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainState = ref.watch(trainSearchProvider);

    var trainsData =
        ref.watch(trainsBySearchController(ref.watch(trainSearchProvider)));
    var screenBody = trainsData.when(
      data: (trains) {
        if (trains.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: trains.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            final train = trains[index];
            return TrainCard(
              train: train,
              departureStation: train.trainDepartureStation,
              arrivalStation: train.trainArrivalStation,
              onTrainSelected: (_) {},
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Column(
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
                trainsData = ref.refresh(
                    trainsBySearchController(ref.watch(trainSearchProvider)));
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () async {
                  OpenDialogs.openCustomDialog(
                      context: context,
                      dialog: const MahattatyTrainFilterDialog());
                },
                icon: const Icon(Icons.filter_list),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
        child: Column(
          children: [
            TrainCard(
              departureStation: trainState.fromStation,
              arrivalStation: trainState.toStation,
              ticketType: trainState.ticketType,
              seatType: SeatType.business,
              displayTrainTicketCard: true,
            ),
            const SizedBox(height: 10),
            DateList(
              startDate: ref.watch(trainSearchProvider).departureDate.toDate(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: screenBody,
            ),
          ],
        ),
      ),
    );
  }
}
