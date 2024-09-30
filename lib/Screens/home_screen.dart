import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_scaffold.dart';
import 'package:mahattaty/Widgets/train_search_form_selector.dart';
import 'package:mahattaty/Widgets/train_search_form.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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
    final authState = ref.read(authProvider);

    return MahattatyScaffold(
      appBarHeight: 50,
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
                Text('Hi, ${authState.user?.displayName}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface)),
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
      bgHeight: backgroundHeight.medium,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    'images/home1.png',
                  ),
                ),
              ],
            ),
            AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: !isFindTicketClicked
                  ? TrainSearchForm(
                      onSearchClicked: onSearchClicked,
                    )
                  : TrainSearchFormSelector(
                      onSearchClicked: onSearchClicked,
                      onRoundTripClicked: onRoundTripClicked,
                      isRoundTrip: isRoundTrip,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
