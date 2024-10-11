import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/best_offers_trains_controller.dart';

import '../../../../core/generic components/mahattaty_empty_data.dart';
import '../../../../core/generic components/mahattaty_error.dart';
import '../../../../core/generic components/mahattaty_loading.dart';

class BestOffers extends ConsumerWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainsState = ref.watch(bestOffersTrainsController);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Best Offers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: trainsState.when(
            data: (trains) {
              if (trains.isEmpty) {
                return const MahattatyEmptyData(message: 'No Offers Available');
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trains.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TrainCard(
                        train: trains[index],
                        onTrainSelected: (_, __) {},
                        departureStation: trains[index].trainDepartureStation,
                        arrivalStation: trains[index].trainArrivalStation,
                        displayTrainTicketCard: false,
                      ),
                    ],
                  );
                },
              );
            },
            loading: () => const MahattatyLoading(),
            error: (_, __) => MahattatyError(
                onRetry: () => ref.refresh(bestOffersTrainsController)),
          ),
        ),
      ],
    );
  }
}
