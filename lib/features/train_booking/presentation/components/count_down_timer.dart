import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimer extends ConsumerStatefulWidget {
  final DateTime targetDateTime; // Assuming target is of type DateTime

  const CountdownTimer({Key? key, required this.targetDateTime})
      : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer> {
  late Duration remainingDuration;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Calculate the remaining duration at the start
    remainingDuration = widget.targetDateTime.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the remaining duration
      setState(() {
        remainingDuration = widget.targetDateTime.difference(DateTime.now());
        if (remainingDuration.isNegative) {
          // Stop the timer if time is up
          _timer.cancel();
          remainingDuration = Duration.zero; // Set to zero
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String formatDuration(Duration d) {
      String twoDigitHours = twoDigits(d.inHours);
      String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Ends in ',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              children: [
                TextSpan(
                  text: formatDuration(remainingDuration),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
