import 'package:flutter/material.dart';
import 'package:mahattaty/authentication/presentation/screens/authentication_screen.dart';
import 'package:mahattaty/core/utils/open_screens.dart';

import '../../../../core/generic components/mahattaty_alert.dart';
import '../components/section_header.dart';
import '../components/settings_tile.dart';
import 'edit_profile_screen.dart';
import 'legal_and_policies_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SectionHeader(title: 'General'),
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              OpenScreen.openScreenWithSmoothAnimation(
                context,
                const EditProfileScreen(),
                false,
              );
            },
          ),
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            trailingText: 'English',
            onTap: () {},
          ),
          const SectionHeader(title: 'Preferences'),
          SettingsTile(
            icon: Icons.policy_outlined,
            title: 'Legal and Policies',
            onTap: () {
              OpenScreen.openScreenWithSmoothAnimation(
                context,
                const LegalAndPoliciesScreen(),
                false,
              );
            },
          ),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              mahattatyAlertDialog(
                context,
                message: 'Are you sure you want to logout?',
                type: MahattatyAlertType.info,
                showCancelButton: true,
                onOk: () {
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
