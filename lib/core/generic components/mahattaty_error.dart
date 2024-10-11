import 'package:flutter/material.dart';

class MahattatyError extends StatelessWidget {
  const MahattatyError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Error While Fetching Trains, Please Try Again !!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
