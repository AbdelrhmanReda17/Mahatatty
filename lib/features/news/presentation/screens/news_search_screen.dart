import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/features/news/presentation/components/cards/skeletons/news_card_skeleton.dart';
import '../../../../core/generic components/mahattaty_search.dart';
import '../components/Cards/news_card.dart';
import '../controllers/news_by_query_controller.dart';

class NewsSearchScreen extends ConsumerStatefulWidget {
  const NewsSearchScreen({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  NewsSearchScreenState createState() => NewsSearchScreenState();
}

class NewsSearchScreenState extends ConsumerState<NewsSearchScreen> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsByQueryController(searchQuery));
    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'Search Results',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MahattatySearch(
              onPressed: (value) {
                setState(() {
                  searchQuery = value;
                });
                ref.refresh(newsByQueryController(searchQuery));
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: newsState.when(
              data: (news) {
                if (news.isEmpty) {
                  return Center(
                    child: Text(
                      'No results found for "$searchQuery"',
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
                        ref.refresh(newsByQueryController as Refreshable);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
