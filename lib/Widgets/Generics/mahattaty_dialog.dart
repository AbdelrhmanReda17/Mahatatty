import 'package:flutter/material.dart';
import 'mahattaty_button.dart';

enum ContentPlacement {
  beforeTitle,
  afterTitle,
}

class MahattatyDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> content;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final ContentPlacement contentPlacement;
  final TextAlign textAlign;

  const MahattatyDialog({
    required this.title,
    required this.description,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    this.contentPlacement = ContentPlacement.afterTitle,
    this.textAlign = TextAlign.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 30.0, bottom: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (contentPlacement == ContentPlacement.beforeTitle) ...[
            ...content,
            const SizedBox(height: 20),
            _buildAlignedText(
                title,
                Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildAlignedText(
                description,
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    )),
          ] else ...[
            _buildAlignedText(
                title,
                Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildAlignedText(
                description,
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    )),
            const SizedBox(height: 20),
            ...content,
          ],
          const SizedBox(height: 20),
          MahattatyButton(
            text: buttonText,
            style: MahattatyButtonStyle.primary,
            onPressed: onButtonPressed,
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget _buildAlignedText(String text, TextStyle? style) {
    return Align(
      alignment: _getAlignmentFromTextAlign(textAlign),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }

  Alignment _getAlignmentFromTextAlign(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
