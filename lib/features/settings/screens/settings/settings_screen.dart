import 'package:flutter/material.dart';

import '../../dialogs/logout_dialog.dart';
import '../../widgets/section_header.dart';
import '../../widgets/settings_tile.dart';
import '../edit_profile_screen/edit_profile_screen.dart';
import '../legal_and_policies_screen/legal_and_policies_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Open more options menu
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SectionHeader(title: 'General'),
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              // Navigate to Change Password screen
            },
          ),
          SettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            trailingText: 'English',
            onTap: () {
              // Navigate to Language selection
            },
          ),
          const SectionHeader(title: 'Preferences'),
          SettingsTile(
            icon: Icons.policy_outlined,
            title: 'Legal and Policies',
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LegalAndPoliciesScreen()),
              );
            },
          ),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              // Navigate to Help & Support screen
            },
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LogoutDialog();
      },
    );
  }
}
