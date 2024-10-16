import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/generic components/mahattaty_empty_data.dart';
import '../../../../core/generic components/mahattaty_error.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../../../core/generic components/mahattaty_search.dart';
import '../components/Cards/news_card.dart';
import '../components/cards/skeletons/news_card_skeleton.dart';
import '../controllers/news_by_query_controller.dart';
import '../controllers/search_news_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsSearchScreen extends ConsumerWidget {
  const NewsSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData =
        ref.watch(newsByQueryController(ref.watch(newsSearchProvider)));

    final surfaceColor = Theme.of(context).colorScheme.surface;
    var screenBody = newsData.when(
      data: (news) {
        if (news.isEmpty) {
          return  MahattatyEmptyData(message: AppLocalizations.of(context)!.emptyNews);
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
      error: (error, stackTrace) => MahattatyError(
        onRetry: () => ref.refresh(
          newsByQueryController(
            ref.watch(newsSearchProvider),
          ),
        ),
      ),
    );
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.searchResults,
              style: TextStyle(
                color: surfaceColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body:
         Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MahattatySearch(
                onPressed: (value) {
                  ref.read(newsSearchProvider.notifier).state =
                      ref.read(newsSearchProvider).copyWith(query: value);
                  ref.refresh(
                      newsByQueryController(ref.watch(newsSearchProvider)));
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: screenBody,
              ),
            ),
          ],
        ),

    );
  }
}
