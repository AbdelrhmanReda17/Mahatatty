import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/screens/authentication_screen.dart';
import 'package:mahattaty/features/settings/presentation/components/change_language_dialog.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/settings/presentation/controllers/settings_controller.dart';
import '../../../../authentication/presentation/controllers/auth_controller.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../components/section_header.dart';
import '../components/settings_tile.dart';
import 'edit_profile_screen.dart';
import 'legal_and_policies_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
           SectionHeader(title: AppLocalizations.of(context)!.general),
          SettingsTile(
            icon: Icons.person_outline,
            title: AppLocalizations.of(context)!.editProfile,
            onTap: () {
              OpenScreen.openScreenWithSmoothAnimation(
                context,
                const EditProfileScreen(),
                false,
              );
            },
          ),
          SettingsTile(
            icon: Icons.language_outlined,
            title: AppLocalizations.of(context)!.languageLabel,
            trailingText: AppLocalizations.of(context)!.language,
            onTap: () {
              OpenDialogs.openCustomDialog(
                context: context,
                dialog: const ChangeLanguageDialog(),
              );
            },
          ),
          SettingsTile(
            trailingText: '',
            icon: ref.read(settingsControllerProvider).mode == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            title: ref.read(settingsControllerProvider).mode == ThemeMode.light
                ? AppLocalizations.of(context)!.darkMode
                : AppLocalizations.of(context)!.lightMode,
            onTap: () async {
              await ref.read(settingsControllerProvider.notifier).changeMode(
                  ref.read(settingsControllerProvider).mode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
          ),
    SectionHeader(title: AppLocalizations.of(context)!.preferences),
          SettingsTile(
            icon: Icons.policy_outlined,
            title: AppLocalizations.of(context)!.legal,
            onTap: () {
              OpenScreen.openScreenWithSmoothAnimation(
                context,
                const LegalAndPoliciesScreen(),
                false,
              );
            },
          ),
          SettingsTile(
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.logout,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              mahattatyAlertDialog(
                context,
                message: AppLocalizations.of(context)!.logoutConfirmation,
                type: MahattatyAlertType.info,
                showCancelButton: true,
                onOk: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  OpenScreen.openScreenWithSmoothAnimation(
                    context,
                    const AuthenticationScreen(
                      key: Key('login_screen'),
                    ),
                    true,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
