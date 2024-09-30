import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Helpers/train_station_details.dart';

import '../Themes/light_theme.dart';
import '../Widgets/Generics/weather_widget.dart';
import '../Widgets/train_ticket_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends ConsumerState<ExploreScreen> {
  bool isSearching = false;

  void onExploreButtonClicked() {
    setState(() {
      isSearching = !isSearching;
    });
  }

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
                  'Explore',
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
                    FontAwesomeIcons.bell,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                print("Notification icon tapped");
              },
            ),
          ],
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
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
            const WeatherWidget(
              location: 'Staten Island',
              city: 'New Work',
              time: '08:12 AM',
              condition: WeatherCondition.snowy,
              temperature: '-5°C',
              windSpeed: '5Km/h',
              humidity: '56%',
              visibility: '2.3 km',
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [
                  // Best Offers Section
                  SectionTitle(title: 'Best Offers'),
                  TrainTicketCard(),
                  TrainTicketCard(),

                  // Popular Routes Section
                  SectionTitle(title: 'Popular Routes'),
                  TrainTicketCard(),
                  TrainTicketCard(),

                  // Last Minute Deals Section
                  SectionTitle(title: 'Last Minute Deals'),
                  TrainTicketCard(),
                  TrainTicketCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
