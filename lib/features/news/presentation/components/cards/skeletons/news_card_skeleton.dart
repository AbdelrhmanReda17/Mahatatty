import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsCardSkeleton extends StatelessWidget {
  const NewsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      child: Card(
        elevation: 4,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: const Bone.text(),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bone.text(),
              SizedBox(height: 5),
              Bone.text(),
            ],
          ),
          trailing: Bone.square(
            size: 100,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
