import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MahattatyError extends StatelessWidget {
  const MahattatyError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.fetchError,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.retryButton),
          ),
        ],
      ),
    );
  }
}
