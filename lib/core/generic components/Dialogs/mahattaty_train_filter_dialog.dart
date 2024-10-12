import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_dialog.dart';

import '../../../features/train_booking/presentation/components/train_type_selector.dart';

class MahattatyTrainFilterDialog extends StatefulWidget{
  const MahattatyTrainFilterDialog({super.key});

  @override
  State<StatefulWidget> createState() => _MahattatyTrainFilterDialogState();
  
}

class _MahattatyTrainFilterDialogState extends State<MahattatyTrainFilterDialog>{
  List<String> trainTypes = ['Express', 'Ordinary'];
  List<String> selectedTrainTypes = [];
  
  double minPrice = 0.0;
  double maxPrice = 200.0;

  bool isTrainTypeSelected = false;

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Filter',
      description: "Select Your Filters Below",
      buttonText: 'Apply Filter',
      onButtonPressed: (){
        // widget.onSelected(selectedStation);
        Navigator.of(context).pop();
      },
      content: [
        _buildFilterSection('Train Type', trainTypes, selectedTrainTypes, (value) {
          setState(() {
            if (selectedTrainTypes.contains(value)) {
              selectedTrainTypes.remove(value);
            } else {
              selectedTrainTypes.add(value);
            }
          });
        }),
        const SizedBox(height: 20),
        _buildPriceSlider(),
      ],

    );
  }

  Widget _buildFilterSection(String title, List<String> options, List<String> selectedOptions, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            TrainTypeSelector(
              isSelected: isTrainTypeSelected,
              trainType: 'Express',
              onSelected: (isSelected){
                  setState(() {
                    isTrainTypeSelected = isSelected;
                  });
              },
            ),
            const SizedBox(width: 10),
            TrainTypeSelector(
              isSelected: isTrainTypeSelected,
              trainType: 'Ordinary',
              onSelected: (isSelected){
                  setState(() {
                    isTrainTypeSelected = isSelected;
                  });
              },
            )
          ]
        ),
      ],
    );
  }


  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ticket Price',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
        RangeSlider(
          values: RangeValues(minPrice, maxPrice),
          min: 0,
          max: 200,
          divisions: 50,
          onChanged: (values) {
            setState(() {
              minPrice = values.start;
              maxPrice = values.end;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${minPrice.toStringAsFixed(0)}EGP',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ), // Min price on the left
              Text(
                '${maxPrice.toStringAsFixed(0)}EGP',
                style: const TextStyle(
                    fontSize: 12,
                ),
              ), // Max price on the right
            ],
          ),
        ),
      ],
    );
  }

}


