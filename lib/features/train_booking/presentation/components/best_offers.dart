import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/best_offers_trains_controller.dart';

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
                return Center(
                  child: Text(
                    'No Offer Available',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trains.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TrainCard(
                          train: trains[index],
                          onTrainSelected: (_) {},
                          departureStation: trains[index].trainDepartureStation,
                          arrivalStation: trains[index].trainArrivalStation,
                          displayTrainTicketCard: false,
                        ),
                      ],
                    );
                  },
                );
              }
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Error While Fetching News, Please Try Again',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.refresh(bestOffersTrainsController);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
