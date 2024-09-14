import 'package:flutter/material.dart';

class MahattatyTextFormField extends StatefulWidget {
  const MahattatyTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.textStyle,
    this.iconData,
    this.keyboardType = TextInputType.text,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 20.0,
    this.counterText = '',
    this.maxLength = 50,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.onChanged,
    this.fieldKey,
  });

  final String? labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final IconData? iconData;
  final double verticalPadding;
  final double horizontalPadding;
  final String? counterText;
  final int maxLength;
  final TextAlign textAlign;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;
  final GlobalKey<FormFieldState>? fieldKey;

  @override
  State<MahattatyTextFormField> createState() => _MahattatyTextFormFieldState();
}

class _MahattatyTextFormFieldState extends State<MahattatyTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    widget.controller.addListener(() {
      setState(() {});
    });
    setState(() {
      isPasswordVisible = widget.isPassword;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;

    bool hasText = widget.controller.text.isNotEmpty;
    bool shouldBeFocused = isFocused || hasText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Text(
                widget.labelText!,
                style: bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5,
                    ) ??
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5,
                    ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 10.0),
        TextFormField(
          key: widget.fieldKey,
          focusNode: _focusNode,
          autocorrect: true,
          controller: widget.controller,
          validator: widget.validator, // Use validator for error handling
          textAlign: widget.textAlign,
          keyboardType: widget.keyboardType,
          style: widget.textStyle,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          onChanged: widget.onChanged,
          obscureText: isPasswordVisible,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            counterText: widget.counterText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: shouldBeFocused
                  ? BorderSide(
                      color: colorScheme.onPrimaryContainer,
                    )
                  : BorderSide.none,
            ),
            filled: true,
            fillColor: shouldBeFocused
                ? colorScheme.background
                : colorScheme.primaryContainer,
            prefixIcon: widget.iconData != null
                ? Icon(
                    widget.iconData,
                    color: shouldBeFocused
                        ? colorScheme.primary
                        : colorScheme.onPrimaryContainer,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50.0,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
            hintStyle: bodyLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ) ??
                const TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
