import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/screens/seat_selection_screen.dart';

import '../../../../core/generic components/mahattaty_empty_data.dart';
import '../../../../core/generic components/mahattaty_error.dart';
import '../../../../core/generic components/mahattaty_loading.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../../../core/utils/open_screens.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train_seat.dart';
import '../components/cards/train_card.dart';
import '../components/date_list.dart';
import '../controllers/get_trains_by_search_controller.dart';
import '../controllers/search_train_controller.dart';

class TrainSearchScreen extends ConsumerWidget {
  final TicketType type;

  const TrainSearchScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainState = ref.watch(trainSearchProvider);
    var trainsData =
        ref.watch(trainsBySearchController(ref.watch(trainSearchProvider)));

    var screenBody = trainsData.when(
      data: (trains) {
        if (trains.isEmpty) {
          return const MahattatyEmptyData(message: 'No Trains Available');
        }
        return ListView.builder(
          itemCount: trains.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            final train = trains[index];
            return Column(
              children: [
                TrainCard(
                  train: train,
                  departureStation: train.trainDepartureStation,
                  arrivalStation: train.trainArrivalStation,
                  onTrainSelected: (ticket, selectedTrain) {
                    if (selectedTrain != null) {
                      OpenScreen.openScreenWithSmoothAnimation(
                        context,
                        SeatSelectionScreen(train: train, ticketType: type),
                        true,
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      loading: () => const MahattatyLoading(),
      error: (_, __) => MahattatyError(
        onRetry: () => ref.refresh(
          trainsBySearchController(ref.watch(trainSearchProvider)),
        ),
      ),
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
