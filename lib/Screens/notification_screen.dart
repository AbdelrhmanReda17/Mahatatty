import 'package:flutter/material.dart';
import '../Widgets/Generics/mahattaty_scaffold.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MahattatyScaffold(
      appBarHeight: 50,
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
        child: Center(
          child: Text(
            'Notifications',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'There are no notifications to show.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
