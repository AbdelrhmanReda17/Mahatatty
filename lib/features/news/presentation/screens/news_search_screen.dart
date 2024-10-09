import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../../../core/generic components/mahattaty_search.dart';
import '../components/Cards/news_card.dart';
import '../components/cards/skeletons/news_card_skeleton.dart';
import '../controllers/news_by_query_controller.dart';
import '../controllers/search_news_controller.dart';

class NewsSearchScreen extends ConsumerWidget {
  const NewsSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData =
        ref.watch(newsByQueryController(ref.watch(newsSearchProvider)));
    var screenBody = newsData.when(
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
    return MahattatyScaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
        child: Column(
          children: [
            MahattatySearch(
              onPressed: (value) {
                ref.read(newsSearchProvider.notifier).state =
                    ref.read(newsSearchProvider).copyWith(query: value);
                ref.refresh(
                    newsByQueryController(ref.watch(newsSearchProvider)));
              },
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
