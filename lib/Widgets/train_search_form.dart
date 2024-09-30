import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_switch.dart';
import 'package:mahattaty/Widgets/Helpers/train_station_details.dart';

class TrainSearchForm extends StatelessWidget {
  final VoidCallback onSearchClicked;

  const TrainSearchForm({Key? key, required this.onSearchClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TrainStationDetails(
                  code: 'NYC',
                  location: 'New York Station',
                  alignment: TrainStationDetailsAlignment.start,
                  direction: TrainStationDirection.origin,
                ),
                Icon(
                  FontAwesomeIcons.rightLeft,
                  color: Colors.blue,
                ),
                TrainStationDetails(
                  code: 'VIT',
                  location: 'Vitoria Station',
                  alignment: TrainStationDetailsAlignment.end,
                  direction: TrainStationDirection.destination,
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
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MahattatySwitch(
                      onChanged: (value) {},
                      value: false,
                      enableColor: Theme.of(context).colorScheme.primary,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Round-trip',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 19,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.circlePlus,
                            color: Theme.of(context).colorScheme.primary,
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
                    onPressed: onSearchClicked,
                    style: MahattatyButtonStyle.primary,
                    text: 'Search for trains',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
