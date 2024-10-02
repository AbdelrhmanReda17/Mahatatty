import 'package:flutter/material.dart';

import '../../Screens/news_detail_screen.dart';

// Define the News class
class News {
  final String title;
  final String imageUrl;
  final String author;
  final String time;
  final String content;

  News({
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.time,
    required this.content,
  });
}


// Create a widget for the latest news card
class LatestNewsCard extends StatelessWidget {
  final News news;

  const LatestNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the NewsDetailScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
              title: news.title,
              imageUrl: news.imageUrl,
              author: news.author,
              time: news.time,
              content: news.content,

            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          news.author,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          news.time,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

