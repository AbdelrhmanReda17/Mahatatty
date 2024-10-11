import 'package:flutter/material.dart';

class MahattatyLoading extends StatelessWidget {
  const MahattatyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
      ],
    );
  }
}
