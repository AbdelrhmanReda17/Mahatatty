import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/news/presentation/components/news_search.dart';
import 'package:mahattaty/features/news/presentation/components/trending_topics.dart';
import 'package:mahattaty/features/train_booking/presentation/components/best_offers.dart';
import '../../core/generic components/mahattaty_scaffold.dart';
import '../../core/utils/open_screens.dart';
import '../../features/news/presentation/controllers/search_news_controller.dart';
import '../../features/news/presentation/screens/news_search_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../news/presentation/controllers/all_news_controller.dart';
import '../train_booking/presentation/controllers/best_offers_trains_controller.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends ConsumerState<ExploreScreen> {
  bool isSearching = false;

  void onExploreButtonClicked() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return MahattatyScaffold(
      appBarContent: Center(
        child: Text(
          AppLocalizations.of(context)!.explore,
          style: TextStyle(
            color: surface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(allNewsController);
          ref.refresh(bestOffersTrainsController);
        },
        child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          children: [
            NewsSearch(
              onPressed: (value) {
                ref.read(newsSearchProvider.notifier).state =
                    ref.read(newsSearchProvider).copyWith(query: value);
                OpenScreen.openScreenWithSmoothAnimation(
                  context,
                  const NewsSearchScreen(),
                  false,
                );
              },
            ),
            const SizedBox(height: 20),
             const TrendingTopics(),
            const SizedBox(height: 22),
            const SizedBox(
              height: 360,
              child: BestOffers(),
            ),
          ],
        ),
      ),
    );
  }
}

