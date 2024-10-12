import 'package:flutter/material.dart';
import '../core/utils.dart';
import '../screens/edit_profile_screen/edit_profile_screen.dart';
import '../screens/legal_and_policies_screen/legal_and_policies_screen.dart';


Map<String, WidgetBuilder> appRoutes = {
  '/settings': (context) => const SettingsScreen(),
  '/editProfile': (context) => const EditProfileScreen(),
 // '/changePassword': (context) => const ChangePasswordScreen(),
  '/legal-and-policies': (context) => const LegalAndPoliciesScreen()
};
