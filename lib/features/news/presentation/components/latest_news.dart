
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_empty_data.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_error.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/news/presentation/components/cards/skeletons/news_card_skeleton.dart';
import 'package:mahattaty/features/news/presentation/screens/news_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/latest_news_controller.dart';
import 'Cards/news_card.dart';

class LatestNews extends ConsumerWidget {
  const LatestNews({super.key, this.seeMoreEnabled = false});

  final bool seeMoreEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newsState = ref.watch(latestNewsController);
    var onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    var bodyLarge = Theme.of(context).textTheme.bodyLarge!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.hotNews,
              style: bodyLarge.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: onPrimaryColor,
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
                  AppLocalizations.of(context)!.seeAll,
                  style: bodyLarge.copyWith(
                        color: onPrimaryColor,
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
                return MahattatyEmptyData(message: AppLocalizations.of(context)!.emptyHotNews);
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
