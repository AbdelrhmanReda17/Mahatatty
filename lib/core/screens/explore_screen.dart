import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_search.dart';
import 'package:mahattaty/features/train_booking/presentation/components/best_offers.dart';

import '../../features/train_booking/presentation/components/cards/train_ticket_card.dart';
import '../generic components/mahattaty_scaffold.dart';

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
      appBarContent: Center(
        child: Text(
          'Explore',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bgHeight: backgroundHeight.large,
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        children: [
          MahattatySearch(
            onPressed: (_) {},
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
          const SizedBox(height: 22),
          const SizedBox(
            height: 360,
            child: BestOffers(),
          ),
        ],
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

enum WeatherCondition {
  sunny(Colors.deepOrange),
  cloudy(Colors.grey),
  rainy(Colors.blue),
  stormy(Color(0XFF492826)),
  snowy(Color(0XFF009494));

  final Color color;

  const WeatherCondition(this.color);
}

class WeatherWidget extends StatelessWidget {
  final String location;
  final String city;
  final String time;
  final WeatherCondition condition;
  final String temperature;
  final String windSpeed;
  final String humidity;
  final String visibility;

  const WeatherWidget({
    Key? key,
    required this.location,
    required this.city,
    required this.time,
    required this.condition,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mapLocationDot,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 15), // Space between icon and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          city + ' City',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            // make the first letter of the condition string uppercase
            condition.toString().split('.').last.toUpperCase(),
            style: TextStyle(
              fontSize: 19,
              color: condition.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail(
                  label: 'Wind',
                  value: windSpeed,
                  icon: FontAwesomeIcons.wind, // Example icon
                ),
                _buildWeatherDetail(
                  label: 'Humidity',
                  value: humidity,
                  icon: Icons.water_drop, // Example icon
                ),
                _buildWeatherDetail(
                  label: 'Visibility',
                  value: visibility,
                  icon: Icons.visibility, // Example icon
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(
      {required String label, required String value, required IconData icon}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
