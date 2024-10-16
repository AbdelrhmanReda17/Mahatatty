import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mahattaty/core/utils/time_converter.dart';
import 'package:mahattaty/features/news/domain/entities/news.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final onPrimaryContainerColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final titleMedium = Theme.of(context).textTheme.titleMedium!;

    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          AppLocalizations.of(context)!.newsDetails,
          style: TextStyle(
            color: surfaceColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Title
          Text(
            news.title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: surfaceColor
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'By ${news.author} • ${TimeConverter.convertTimeToString(news.publishedAt)}',
            style: titleMedium.copyWith(
                  color: onPrimaryContainerColor
                ),
          ),
          const SizedBox(height: 23),
          // Image
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(news.urlToImage),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.error,
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                  );
                },
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            news.description,
            style: TextStyle(
              fontSize: 20,
              color: onPrimaryColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
