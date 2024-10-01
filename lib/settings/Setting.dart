import 'package:flutter/material.dart';
import 'package:mahattaty/settings/Security%20Screen.dart';
import '../Widgets/social_accounts_login.dart';
import 'EditProfile.dart';
import 'LegalAndPolicies.dart';
import 'Notifications Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsScreen(),
    );
  }
}

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
            // Navigate back to the previous screen
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
              // Navigate to Edit Profile screen
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
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
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              // Navigate to Notifications screen
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
            },
          ),
          SettingsTile(
            icon: Icons.security_outlined,
            title: 'Security',
            onTap: () {
              // Navigate to Security settings
              Navigator.push(context, MaterialPageRoute(builder: (_) => SecurityScreen()));
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
              // Navigate to Legal and Policies screen
              Navigator.push(context, MaterialPageRoute(builder: (_) => LegalAndPoliciesScreen()));
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
              // Show Logout confirmation dialog
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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 16, // Same as the settings page text
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.black, // Black color for the text
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Column(
              children: [
                // Logout Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background for logout button
                    foregroundColor: Colors.red, // Red text for logout button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.red), // Red border for Logout button
                    ),
                    minimumSize: const Size(double.infinity, 45), // Full width for the button
                  ),
                  child: const Text('Log Out'),
                  onPressed: () {
                    // Clear stack and navigate to the login screen or another page
                    Navigator.of(context).pushNamedAndRemoveUntil(
                     'log In',
                      // Replace this with your actual login or target screen route
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
                const SizedBox(height: 8), // Add some space between the buttons

                // Cancel Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Background color for Cancel
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 45), // Full width for the button
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final Function() onTap;
  final Color? iconColor;
  final Color? textColor;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      trailing: trailingText != null
          ? Text(
        trailingText!,
        style: const TextStyle(color: Colors.black45),
      )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
