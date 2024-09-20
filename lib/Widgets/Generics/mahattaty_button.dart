import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MahattatyButtonStyle {
  primary,
  secondary,
}

enum MahattatyIconPosition {
  start,
  end,
}

class MahattatyButton extends StatelessWidget {
  const MahattatyButton({
    super.key,
    required this.style,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.width = double.infinity,
    this.height = 50.0,
    this.iconData,
    this.svgPicture,
    this.iconPosition = MahattatyIconPosition.start,
    this.spacing = 10.0,
    this.textStyle,
    this.elevation = 0.0,
    this.verticalPadding = 10.0,
    this.horizontalPadding = 20.0,
    this.borderColor,
  });

  final MahattatyButtonStyle style;
  final double width;
  final bool disabled;
  final double height;
  final String text;
  final void Function()? onPressed;
  final IconData? iconData;
  final String? svgPicture;
  final MahattatyIconPosition iconPosition;
  final double spacing;
  final TextStyle? textStyle;
  final double elevation;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? borderColor;

  List<Widget> mahattatyButtonIcon(BuildContext context) => [
        if (iconPosition == MahattatyIconPosition.end) SizedBox(width: spacing),
        iconData == null
            ? SvgPicture.asset(
                svgPicture!,
                height: 24,
              )
            : Icon(
                iconData,
                size: textStyle?.fontSize ??
                    Theme.of(context).textTheme.bodyLarge!.fontSize,
                weight: textStyle?.fontWeight?.value.toDouble() ??
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .fontWeight!
                        .value
                        .toDouble(),
                color: textStyle?.color,
              ),
        if (iconPosition == MahattatyIconPosition.start)
          SizedBox(width: spacing),
      ];

  Widget returnMahattatyButton(BuildContext context, Widget child) {
    if (style == MahattatyButtonStyle.primary) {
      return ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          elevation: elevation,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
        child: child,
      );
    } else if (style == MahattatyButtonStyle.secondary) {
      return OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width, height),
          side: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
          ),
          elevation: elevation,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
        child: child,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return returnMahattatyButton(
      context,
      disabled
          ? const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3.0,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPosition == MahattatyIconPosition.start &&
                    (iconData != null || svgPicture != null)) ...[
                  ...mahattatyButtonIcon(context)
                ],
                Text(
                  text,
                  style: textStyle,
                ),
                if (iconPosition == MahattatyIconPosition.end &&
                    (iconData != null || svgPicture != null))
                  ...mahattatyButtonIcon(context)
              ],
            ),
    );
  }
}
