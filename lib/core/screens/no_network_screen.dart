import 'package:flutter/material.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key , required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please check your internet connection and try again',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:onPressed,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
