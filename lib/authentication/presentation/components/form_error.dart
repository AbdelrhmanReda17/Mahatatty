import 'package:flutter/material.dart';

class FormError extends StatefulWidget {
  const FormError({super.key, required this.message, this.isShow = false});

  final String message;
  final bool isShow;

  @override
  FormErrorState createState() => FormErrorState();
}

class FormErrorState extends State<FormError>
    with SingleTickerProviderStateMixin {
  String get message => widget.message;

  bool get isShow => widget.isShow;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Initialize fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _buildErrorWidget(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 10), // Add spacing between icon and text
          Expanded(
            // Ensure the text fits within the row and wraps properly
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: isShow ? _buildErrorWidget(message) : const SizedBox.shrink(),
    );
  }
}
