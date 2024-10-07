import 'package:flutter/material.dart';

class OpenDialogs {
  static void openCustomDialog(
      {required BuildContext context, required Widget dialog}) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: dialog,
        );
      },
    );
  }
}
