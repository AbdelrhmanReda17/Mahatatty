import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/news/presentation/components/cards/skeletons/trending_news_card_skeleton.dart';
import '../../../../core/utils/open_screens.dart';
import '../controllers/all_news_controller.dart';
import '../screens/news_screen.dart';
import 'Cards/trending_news_card.dart';

class TrendingTopics extends ConsumerWidget {
  const TrendingTopics({super.key, this.seeMoreEnabled = false});

  final bool seeMoreEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(allNewsController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Topic',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            if (seeMoreEnabled)
              TextButton(
                onPressed: () {
                  OpenScreen.openScreenWithSmoothAnimation(
                    context,
                    const NewsScreen(),
                    false,
                  );
                },
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: newsState.when(
            data: (news) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TrendingNewsCard(news: news[index]),
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
                    child: TrendingNewsCardSkeleton(),
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Error While Fetching News, Please Try Again ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.refresh(allNewsController);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Same logic applies to LatestNews
