import 'package:flutter/material.dart';

class MahattatySwitch extends StatefulWidget {
  final bool value;
  final Color enableColor;
  final Color disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;
  final ValueChanged<bool> onChanged;

  const MahattatySwitch({
    super.key,
    required this.value,
    this.enableColor = Colors.blue,
    this.disableColor = Colors.grey,
    this.width = 48.0,
    this.height = 24.0,
    this.switchHeight = 20.0,
    this.switchWidth = 20.0,
    required this.onChanged,
  });

  @override
  MahattatySwitchState createState() => MahattatySwitchState();
}

class MahattatySwitchState extends State<MahattatySwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _alignment = widget.value ? Alignment.centerRight : Alignment.centerLeft;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant MahattatySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      toggleSwitch();
    }
  }

  void toggleSwitch() {
    setState(() {
      _alignment = widget.value ? Alignment.centerRight : Alignment.centerLeft;
      widget.value
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: _alignment,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: widget.value ? widget.enableColor : widget.disableColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                widget.value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: widget.switchWidth,
              height: widget.switchHeight,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
