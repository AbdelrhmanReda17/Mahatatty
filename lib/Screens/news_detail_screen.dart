import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/Generics/mahattaty_scaffold.dart';

// Create a screen to display news details using MahattatyScaffold
class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String author;
  final String time;
  final String content;

  const NewsDetailScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.time,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Stack(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.heart,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
              onPressed: () {
                print("Heart icon tapped");
              },
            ),
          ],
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
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
            ),
            SizedBox(height: 20),
            Text('By $author • $time', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 23),
            // Image
            Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Detailed content about the news
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
