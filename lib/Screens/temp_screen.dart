import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/authentication_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';

class TempScreen extends ConsumerWidget {
  const TempScreen({super.key});

  String get routeName => '/temp';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Screen'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('This is a temporary screen'),
          ),
          ElevatedButton(
            onPressed: () {
              authNotifier.signOut();
              openScreen(
                context: context,
                routeName: const AuthenticationScreen().loginRouteName,
                isReplace: true,
              );
            },
            child: const Text('Go Back'),
          )
        ],
      ),
    );
  }
}
