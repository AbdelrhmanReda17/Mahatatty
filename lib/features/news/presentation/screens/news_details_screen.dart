import 'package:flutter/material.dart';
import 'package:mahattaty/core/utils/time_converter.dart';
import 'package:mahattaty/features/news/domain/entities/news.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../core/generic components/mahattaty_scaffold.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'Details',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              news.title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface),
            ),
            const SizedBox(height: 20),
            Text(
              'By ${news.author} • ${TimeConverter.convertTimeToString(news.publishedAt)}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w400,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
