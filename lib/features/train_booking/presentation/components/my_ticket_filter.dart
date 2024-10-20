import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import '../../domain/entities/train.dart';

class MyTicketsFilter extends StatelessWidget {
  final int? selectedValue;
  final ValueChanged<int?> onSelected;

  const MyTicketsFilter({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> filters = [
      AppLocalizations.of(context)!.all,
      for (final TrainType status in TrainType.values) AppLocalizations.of(context)!.train(status),
    ];
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.085,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = selectedValue == index;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              showCheckmark: false,
              backgroundColor: primaryColor,
              selectedColor: surfaceColor,
              side: BorderSide(
                color: surfaceColor,
                width: 1,
              ),
              disabledColor: Colors.white,
              labelStyle: isSelected
                  ? TextStyle(
                color: primaryColor,
                fontSize: 17,
              )
                  : TextStyle(color: surfaceColor),
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onSelected(
                    index,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}