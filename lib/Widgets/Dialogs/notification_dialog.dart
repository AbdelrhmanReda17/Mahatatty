import 'package:flutter/material.dart';

import '../Generics/mahattaty_circle_icon.dart';
import '../Generics/mahattaty_dialog.dart';

enum NotificationType {
  success,
  error,
  warning,
}

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    this.onButtonPressed,
    required this.type,
  });

  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: title,
      description: description,
      content: [
        Center(
          child: MahattatyCircleIcon(
            innerCircleColor: type == NotificationType.success
                ? const Color(0xff00d261)
                : type == NotificationType.error
                    ? const Color(0xffFF0000)
                    : const Color(0xffFFA500),
            child: Icon(
              icon,
              size: 40,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        )
      ],
      buttonText: buttonText,
      onButtonPressed: () {
        Navigator.of(context).pop();
        if (onButtonPressed != null) {
          onButtonPressed!();
        }
      },
      textAlign: TextAlign.center,
      contentPlacement: ContentPlacement.beforeTitle,
    );
  }
}
