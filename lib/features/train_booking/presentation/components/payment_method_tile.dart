import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final String assetPath;
  final String label;
  final String detail;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    Key? key,
    required this.assetPath,
    required this.label,
    required this.detail,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  assetPath,
                  width: 33,
                  height: 33,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 33,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (detail.isNotEmpty)
                      Text(
                        detail,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
