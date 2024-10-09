import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.isEnabled,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onSelect,
  });

  final bool isEnabled;
  final String date;
  final String day;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onSelect : null,
      child: Container(
        width: 50,
        height: 90,
        decoration: BoxDecoration(
          color: !isEnabled
              ? Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.1)
              : isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                date,
                style: isSelected
                    ? TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20)
                    : const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Text(
                day,
                style: isSelected
                    ? TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary)
                    : TextStyle(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
              )
            ],
          ),
        ),
      ),
    );
  }
}
