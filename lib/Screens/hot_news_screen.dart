import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_scaffold.dart';
import '../Utils/constant.dart';
import '../Widgets/Generics/news_card.dart';
import '../Widgets/Generics/trending_news_card.dart';
import 'notification_screen.dart';

class HotNewsScreen extends ConsumerStatefulWidget {
  const HotNewsScreen({super.key});

  @override
  HotNewsScreenState createState() => HotNewsScreenState();
}

class HotNewsScreenState extends ConsumerState<HotNewsScreen> {
  bool isSearching = false;

  void onExploreButtonClicked() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Example news items
    final News exampleNews = News(
        title: '2 Central American migrants found dead in Mexico After Trying',
        imageUrl: newsPhoto,
        author: 'Brianna Wiest',
        time: '28h ago',
        content: 'Authorities have reported the tragic discovery of two Central American migrants who were found dead in Mexico after attempting to cross the border. The details surrounding their deaths are still under investigation, highlighting the dangers faced by migrants seeking a better life.' // Add detailed content here
    );

    final News trendingNews1 = News(
        title: 'New Study Reveals Health Benefits of Coffee',
        imageUrl: newsPhoto,
        author: 'Jane Smith',
        time: '3h ago',
        content: 'A recent study has found that coffee consumption may have several health benefits, including improved cognitive function and a reduced risk of certain diseases. Researchers encourage moderation and further studies to understand the long-term effects of coffee on health.' // Add detailed content here
    );


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
                  'Hot News',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.bell,
                color: Theme.of(context).colorScheme.surface,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
            ),
          ],
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  child: TextField(
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
                    decoration: InputDecoration(
                      hintText: 'What are you looking for?',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
                      fillColor: Theme.of(context).colorScheme.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Theme.of(context).colorScheme.primaryContainer),
                        onPressed: () {
                          print('Search button pressed');
                        },
                      ),
                    ),
                    onTap: () {
                      // Clear text when clicked
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Trending Topics Section
            Align(
                alignment: Alignment.centerLeft,

              child:
                Text(
                  'Trending Topic',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 350,

              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TrendingNewsWidget(
                    title: trendingNews1.title,
                    author: trendingNews1.author,
                    time: trendingNews1.time,
                    backgroundImageUrl: trendingNews1.imageUrl,
                    content: trendingNews1.content,
                  ),
                  const SizedBox(width: 10),
                  TrendingNewsWidget(
                    title: trendingNews1.title,
                    author: trendingNews1.author,
                    time: trendingNews1.time,
                    backgroundImageUrl: trendingNews1.imageUrl,
                    content: trendingNews1.content,
                  ),
                  const SizedBox(width: 10),
                  TrendingNewsWidget(
                    title: trendingNews1.title,
                    author: trendingNews1.author,
                    time: trendingNews1.time,
                    backgroundImageUrl: trendingNews1.imageUrl,
                    content: trendingNews1.content,
                  ),
                  const SizedBox(width: 10),

                ],
              ),
            ),
            const SizedBox(height: 20),
            // Latest News Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Latest News',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  LatestNewsCard(news: exampleNews),
                  LatestNewsCard(news: trendingNews1),
                  LatestNewsCard(news: exampleNews),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
