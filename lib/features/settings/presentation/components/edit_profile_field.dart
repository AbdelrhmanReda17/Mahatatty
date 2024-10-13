import 'package:flutter/material.dart';

class EditProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController? controller;

  const EditProfileField({
    super.key,
    required this.icon,
    required this.label,
    this.controller,
  });

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
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration.collapsed(
                    hintText: '',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
