import 'package:flutter/material.dart';

import 'mahattaty_button.dart';
import 'mahattaty_text_form_field.dart';

class MahattatyDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> content;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const MahattatyDialog({
    required this.title,
    required this.description,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        content.whereType<MahattatyTextFormField>().forEach((formField) {
          formField.controller.dispose();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(5.0),
                    right: Radius.circular(5.0),
                  ),
                ),
                width: 70,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            ...content, //  content here
            const SizedBox(height: 45),
            MahattatyButton(
              text: buttonText,
              style: MahattatyButtonStyle.primary,
              onPressed: onButtonPressed,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
