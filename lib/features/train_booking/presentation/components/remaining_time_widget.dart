import 'package:flutter/material.dart';

class RemainingTimeWidget extends StatelessWidget {
  final String remainingTime;

  const RemainingTimeWidget({super.key, required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFc0f4ff),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Text(
              "The remaining Time of the order",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              remainingTime,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
