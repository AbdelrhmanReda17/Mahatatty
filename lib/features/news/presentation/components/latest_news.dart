import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_empty_data.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_error.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/news/presentation/components/cards/skeletons/news_card_skeleton.dart';
import 'package:mahattaty/features/news/presentation/screens/news_screen.dart';

import '../controllers/latest_news_controller.dart';
import 'Cards/news_card.dart';

class LatestNews extends ConsumerWidget {
  const LatestNews({super.key, this.seeMoreEnabled = false});

  final bool seeMoreEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newsState = ref.watch(latestNewsController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest News',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
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
        Expanded(
          child: newsState.when(
            data: (news) {
              if (news.isEmpty) {
                return const MahattatyEmptyData(message: 'No News Available');
              }
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return NewsCard(news: news[index]);
                },
              );
            },
            loading: () => ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return const NewsCardSkeleton();
              },
            ),
            error: (error, stackTrace) => MahattatyError(
              onRetry: () => ref.refresh(latestNewsController),
            ),
          ),
        ),
      ],
    );
  }
}
