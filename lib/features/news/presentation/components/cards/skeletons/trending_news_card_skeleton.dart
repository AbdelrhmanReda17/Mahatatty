import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingNewsCardSkeleton extends StatelessWidget {
  const TrendingNewsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Stack(
        children: [
          Bone.square(
            size: 300,
            borderRadius: BorderRadius.circular(10),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(),
                  SizedBox(height: 5),
                  Bone.text(
                    width: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
