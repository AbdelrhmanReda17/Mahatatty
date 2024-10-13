import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../authentication/data/models/user_model.dart';
import '../components/edit_profile_field.dart';
import '../controllers/settings_controller.dart';

class EditProfileScreen extends ConsumerWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;

  EditProfileScreen({super.key, required UserModel user})
      : usernameController = TextEditingController(text: user.name),
        emailController = TextEditingController(text: user.email);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider); // Corrected provider name

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EditProfileField(
              icon: Icons.person,
              label: 'Username',
              controller: usernameController,
            ),
            const SizedBox(height: 16),
            EditProfileField(
              icon: Icons.email,
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 32),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                ref.read(settingsControllerProvider.notifier).editProfile(
                  UserModel(
                    uuid: FirebaseAuth.instance.currentUser!.uid,
                    name: usernameController.text, // Use name instead of displayName
                    email: emailController.text,
                  ),
                );
              },
              child: const Text('Save Changes'),
            ),
            if (state.exception != null)
              Text(
                'Error: ${state.exception.toString()}',
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
