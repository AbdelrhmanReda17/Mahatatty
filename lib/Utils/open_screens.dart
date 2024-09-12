import 'package:flutter/material.dart';

void openScreen({
  required BuildContext context,
  required String routeName,
  bool isReplace = false,
}) {
  if (isReplace) {
    Navigator.of(context).pushReplacementNamed(routeName);
  } else {
    Navigator.of(context).pushNamed(routeName);
  }
}
