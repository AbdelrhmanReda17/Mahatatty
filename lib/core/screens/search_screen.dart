import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/news/presentation/components/Cards/news_card.dart';
import '../../features/news/presentation/components/cards/skeletons/news_card_skeleton.dart';
import '../../features/news/presentation/controllers/news_by_query_controller.dart';
import '../../features/news/presentation/controllers/search_news_controller.dart';
import '../../features/train_booking/domain/entities/ticket.dart';
import '../../features/train_booking/domain/entities/train.dart';
import '../../features/train_booking/domain/entities/train_seat.dart';
import '../../features/train_booking/presentation/components/cards/train_card.dart';
import '../../features/train_booking/presentation/components/search_card.dart';
import '../../features/train_booking/presentation/controllers/get_trains_by_search_controller.dart';
import '../../features/train_booking/presentation/controllers/search_train_controller.dart';
import '../generic components/mahattaty_scaffold.dart';
import '../generic components/mahattaty_search.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isTrain = super.key == const Key('train_search');
    final Widget screenBody;

    if (isTrain) {
      final trainState =
          ref.watch(trainsBySearchController(ref.watch(trainSearchProvider)));
      screenBody = trainState.when(
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
                  ref.refresh(
                      trainsBySearchController(ref.watch(trainSearchProvider)));
                },
                child: const Text('Retry'),
              ),
            ],
          );
        },
      );
    } else {
      final newsState =
          ref.watch(newsByQueryController(ref.watch(newsSearchProvider)));
      screenBody = newsState.when(
        data: (news) {
          if (news.isEmpty) {
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
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsItem = news[index];
              return NewsCard(news: newsItem);
            },
          );
        },
        loading: () => ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const NewsCardSkeleton();
          },
        ),
        error: (error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Error While Fetching News, Please Try Again !!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(
                      newsByQueryController(ref.watch(newsSearchProvider)));
                },
                child: const Text('Retry'),
              ),
            ],
          );
        },
      );
    }

    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: (isTrain)
                ? TrainCard(
                    departureStation:
                        ref.watch(trainSearchProvider).fromStation,
                    arrivalStation: ref.watch(trainSearchProvider).toStation,
                    ticketType: ref.watch(trainSearchProvider).ticketType,
                    seatType: SeatType.business,
                    displayTrainTicketCard: true,
                  )
                : MahattatySearch(
                    onPressed: (value) {
                      ref.read(newsSearchProvider.notifier).state =
                          ref.read(newsSearchProvider).copyWith(query: value);
                      ref.refresh(
                          newsByQueryController(ref.watch(newsSearchProvider)));
                    },
                  ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: screenBody,
          ),
        ],
      ),
    );
  }
}
