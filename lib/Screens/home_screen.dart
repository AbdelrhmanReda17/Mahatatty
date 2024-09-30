import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_scaffold.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_switch.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  bool isSwitched = false;

  void onChanged(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.read(authProvider);
    log(authState.toString());
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Departure',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'NYC',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Text('New York Station',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                          ],
                        ),
                        const Icon(
                          FontAwesomeIcons.rightLeft,
                          color: Colors.blue,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Arrival',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'VIT',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            Text(
                              'Vietnam Station',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.5),
                    Divider(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      thickness: 1,
                    ),
                    const SizedBox(height: 12.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date of departure',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              'Mon, 10 Sep 2023',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            MahattatySwitch(
                              onChanged: onChanged,
                              value: isSwitched,
                              enableColor:
                                  Theme.of(context).colorScheme.primary,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Round-trip',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total passengers',
                              style: TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.circleMinus,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 19,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.circlePlus,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: MahattatyButton(
                            onPressed: () {},
                            style: MahattatyButtonStyle.primary,
                            text: 'Search for trains',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
