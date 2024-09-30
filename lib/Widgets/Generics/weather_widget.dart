import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Themes/light_theme.dart';
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
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
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
                            color: customGrey,
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
            condition.toString().split('.').last,
            style: TextStyle(
              fontSize: 18,
              color: condition.color,
            ),
          ),
          const SizedBox(height: 10),
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

  Widget _buildWeatherDetail({required String label, required String value, required IconData icon}) {
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
