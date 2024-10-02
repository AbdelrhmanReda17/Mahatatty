import 'package:flutter/material.dart';

import '../../Screens/news_detail_screen.dart';

class TrendingNewsWidget extends StatelessWidget {
  final String title;
  final String author;
  final String time;
  final String backgroundImageUrl;
  final String content;


  const TrendingNewsWidget({
    Key? key,
    required this.title,
    required this.author,
    required this.time,
    required this.backgroundImageUrl,
    required this.content,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      // Navigate to the NewsDetailScreen when the card is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetailScreen(
            title: title,
            imageUrl: backgroundImageUrl,
            author: author,
            time: time,
            content: content,
          ),
        ),
      );
      },
    child:Stack(
      children: [
        Container(
          width: 300,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image:AssetImage(backgroundImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$author - $time',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],),
    );
  }
}
