import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';

class CountdownTimer extends ConsumerStatefulWidget {
  final DateTime targetDateTime;
  final Function? onTimerEnd;

  const CountdownTimer(
      {super.key, required this.targetDateTime, this.onTimerEnd});

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends ConsumerState<CountdownTimer> {
  late Duration remainingDuration;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    remainingDuration = widget.targetDateTime.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the remaining duration
      setState(() {
        remainingDuration = widget.targetDateTime.difference(DateTime.now());
        if (remainingDuration.isNegative) {
          // Stop the timer if time is up
          _timer.cancel();
          remainingDuration = Duration.zero;
          if (widget.onTimerEnd != null) {
            widget.onTimerEnd!();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
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

    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: onPrimaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            color: onPrimary,
          ),
          const SizedBox(width: 5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: " ${AppLocalizations.of(context)!.discountEndsIn} ",
              style: TextStyle(
                fontSize: 16,
                color: onPrimary,
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.arabicOrEnglish(formatDuration(remainingDuration)),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: onPrimary,
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
