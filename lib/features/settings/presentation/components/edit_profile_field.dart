import 'package:flutter/material.dart';

class EditProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController? controller;
  final String? value;
  final bool isLink;

  const EditProfileField({
    Key? key,
    required this.icon,
    required this.label,
    this.controller,
    this.value,
    this.isLink = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 16),
              Expanded(
                child: isLink
                    ? Text(
                  value ?? '',
                  style: const TextStyle(fontSize: 16),
                )
                    : TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration.collapsed(
                    hintText: '',
                  ),
                ),
              ),
              if (isLink)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
