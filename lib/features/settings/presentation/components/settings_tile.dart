import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final Function() onTap;
  final Color? iconColor;
  final Color? textColor;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.black),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
      trailing: trailingText != null
          ? Text(
        trailingText!,
        style: const TextStyle(color: Colors.black45),
      )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
