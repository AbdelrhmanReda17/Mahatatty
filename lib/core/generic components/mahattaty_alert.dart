import 'package:flutter/material.dart';

enum MahattatyAlertType { error, success, warning, info }

void mahattatyAlertDialog(
  BuildContext context, {
  required String message,
  required MahattatyAlertType type,
  Function? onOk,
  Function? onCancel,
  bool showCancelButton = false,
  Function? onPop,
}) {
  Color? color;
  IconData? icon;
  switch (type) {
    case MahattatyAlertType.error:
      color = Colors.red;
      icon = Icons.error;
      break;
    case MahattatyAlertType.success:
      color = Colors.green;
      icon = Icons.check_circle;
      break;
    case MahattatyAlertType.warning:
      color = Colors.orange;
      icon = Icons.warning;
      break;
    case MahattatyAlertType.info:
      color = Colors.blue;
      icon = Icons.info;
      break;
  }
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      Navigator.of(context).pop();
      if (onOk != null) {
        onOk();
      }
    },
  );
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
      if (onCancel != null) {
        onCancel();
      }
    },
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 10),
            Text(
              type.toString().split('.').last.toUpperCase(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(message),
        actions: [okButton, cancelButton],
      );
    },
  ).then((value) {
    if (onPop != null) {
      onPop();
    }
  });
}
