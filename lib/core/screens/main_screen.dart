import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/features/news/presentation/components/latest_news.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card_form.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isFindTicketClicked = false;
  bool isRoundTrip = false;

  void onSearchClicked() {
    setState(() {
      isFindTicketClicked = !isFindTicketClicked;
    });
  }

  void onRoundTripClicked(bool value) {
    setState(() {
      isRoundTrip = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      bgHeight: backgroundHeight.medium,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, User',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
                Text(
                  'Let\'s take a vacation',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: const Text(
                    'Where are you going right now?',
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: !isFindTicketClicked
                  ? SearchCard(
                      onSearchClicked: onSearchClicked,
                    )
                  : SearchCardForm(
                      onSearchClicked: onSearchClicked,
                      onRoundTripClicked: onRoundTripClicked,
                      isRoundTrip: isRoundTrip,
                    ),
            ),
            const Expanded(
              child: LatestNews(
                seeMoreEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
