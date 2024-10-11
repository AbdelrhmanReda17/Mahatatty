import 'package:flutter/material.dart';

class MahattatyEmptyData extends StatelessWidget {
  const MahattatyEmptyData({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
