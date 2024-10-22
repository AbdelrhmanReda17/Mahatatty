import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/features/news/presentation/components/latest_news.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../news/presentation/controllers/latest_news_controller.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    final user = ref.watch(authControllerProvider).user;
    return MahattatyScaffold(
      bgHeight: backgroundHeight.medium,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: user?.photoUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  user!.photoUrl!,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      FontAwesomeIcons.user,
                      size: 20,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(
                FontAwesomeIcons.user,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.greetings}  ${user!.name} !',
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
      body: RefreshIndicator(
        onRefresh: () async {
           ref.refresh(latestNewsController);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const SearchCardForm(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: const LatestNews(
                    seeMoreEnabled: true,
                  ),
                )
              ],
            ),
          ),

    );
  }
}
