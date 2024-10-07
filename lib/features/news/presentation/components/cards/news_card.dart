import 'package:flutter/material.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../../core/utils/time_converter.dart';
import '../../../domain/entities/news.dart';
import '../../screens/details_news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          OpenScreen.openScreenWithSmoothAnimation(
              context, NewsDetailScreen(news: news), false);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Padding around the custom tile
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  // Allows the column to take full height
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Space between elements
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    // Add space between title and subtitle
                    RichText(
                      text: TextSpan(
                        text: news.author,
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' - ',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: TimeConverter.convertTimeToString(
                                news.publishedAt),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Space between text and image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(news.urlToImage),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).colorScheme.error,
                      width: 100,
                      height: 80,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  width: 100,
                  height: 70,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
