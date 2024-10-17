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
  final bool showButton;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool disabled;
  final ContentPlacement contentPlacement;
  final TextAlign textAlign;

  const MahattatyDialog({
    required this.title,
    required this.description,
    required this.content,
    this.showButton = true,
    required this.buttonText,
    this.disabled = false,
    required this.onButtonPressed,
    this.contentPlacement = ContentPlacement.afterTitle,
    this.textAlign = TextAlign.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        );

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (contentPlacement == ContentPlacement.beforeTitle) ...[
            ...content,
            const SizedBox(height: 20),
            _buildAlignedText(title, titleStyle),
            const SizedBox(height: 10),
            _buildAlignedText(description, descriptionStyle),
          ] else ...[
            _buildAlignedText(title, titleStyle),
            const SizedBox(height: 10),
            _buildAlignedText(description, descriptionStyle),
            const SizedBox(height: 20),
            ...content,
          ],
          const SizedBox(height: 20),
          if (showButton)
            MahattatyButton(
              text: buttonText,
              style: MahattatyButtonStyle.primary,
              disabled: disabled,
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
