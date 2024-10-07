import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/bestOffersTrainsController.dart';

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
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trains.length,
                itemBuilder: (context, index) {
                  return TrainCard(
                    train: trains[index],
                    onTrainSelected: (_) {},
                    displayTrainTicketCard: false,
                  );
                },
              );
            },
            loading: () {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: const Text(''),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              log('Error: $error');
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
