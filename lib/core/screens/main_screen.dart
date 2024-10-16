import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/features/news/presentation/components/latest_news.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    return MahattatyScaffold(
      bgHeight: backgroundHeight.medium,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.greetings}${ref.watch(authControllerProvider).user!.name} !',
                  style: TextStyle(
                    fontSize: 16,
                    color: surfaceColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.greetingsSubtitle,
                  style: TextStyle(
                      color: onPrimaryContainerColor.withOpacity(0.7),
                      fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SearchCardForm(),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const LatestNews(
                  seeMoreEnabled: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
