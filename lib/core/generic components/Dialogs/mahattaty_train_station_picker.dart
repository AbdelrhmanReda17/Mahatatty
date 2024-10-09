import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_dialog.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train.dart';

class MahattatyTrainStationPicker extends StatefulWidget {
  const MahattatyTrainStationPicker({super.key, required this.onSelected});

  final Function(TrainStations value) onSelected;

  @override
  State<MahattatyTrainStationPicker> createState() =>
      _MahattatyTrainStationPickerState();
}

class _MahattatyTrainStationPickerState
    extends State<MahattatyTrainStationPicker> {
  TrainStations selectedStation = TrainStations.cairo;

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Select Station',
      description: 'Select the station you want to travel from',
      buttonText: 'Select',
      onButtonPressed: () {
        widget.onSelected(selectedStation);
        Navigator.of(context).pop();
      },
      content: [
        SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedStation = TrainStations.values[index];
              });
            },
            selectionOverlay: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            useMagnifier: true,
            children: [
              for (var station in TrainStations.values)
                Center(
                  child: Text(
                    station.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
