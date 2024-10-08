import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/screens/search_screen.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/news/presentation/components/latest_news.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import '../../../../core/generic components/mahattaty_search.dart';
import '../components/trending_topics.dart';
import '../controllers/all_news_controller.dart';
import '../controllers/latest_news_controller.dart';
import '../controllers/search_news_controller.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            'Hot News',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(latestNewsController);
          ref.refresh(allNewsController);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              MahattatySearch(
                onPressed: (value) {
                  ref.read(newsSearchProvider.notifier).state =
                      ref.read(newsSearchProvider).copyWith(query: value);
                  OpenScreen.openScreenWithSmoothAnimation(
                    context,
                    const SearchScreen(
                      key: Key('news_search'),
                    ),
                    false,
                  );
                },
              ),
              const SizedBox(height: 20),
              const TrendingTopics(),
              const SizedBox(height: 20),
              const Expanded(
                child: LatestNews(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
