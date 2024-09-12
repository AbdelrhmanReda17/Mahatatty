import 'package:flutter/material.dart';

class MahattatyTextFormField extends StatefulWidget {
  const MahattatyTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.errorText,
    this.textStyle,
    this.iconData,
  });

  final String labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final TextStyle? textStyle;
  final IconData? iconData;

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
        Text(
          widget.labelText,
          style: bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17.5,
              ) ??
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          focusNode: _focusNode,
          autocorrect: true,
          controller: widget.controller,
          validator: widget.validator,
          style: widget.textStyle,
          obscureText: isPasswordVisible,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide:
                  shouldBeFocused ? const BorderSide() : BorderSide.none,
            ),
            filled: true,
            fillColor: shouldBeFocused
                ? colorScheme.background
                : colorScheme.primaryContainer,
            prefixIcon: widget.iconData != null
                ? Icon(
                    widget.iconData,
                    color: shouldBeFocused && widget.errorText == null
                        ? colorScheme.primary
                        : widget.errorText != null
                            ? colorScheme.error
                            : colorScheme.onPrimaryContainer,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50.0,
            ),
            errorText: widget.errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: colorScheme.error,
              ),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            hintStyle: bodyLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ) ??
                const TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: widget.hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
