import 'package:flutter/material.dart';
import '../../../../data/models/activity_model.dart';

class ActivityDetailHeader extends StatelessWidget {
  final ActivityModel activity;
  const ActivityDetailHeader({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: activity.id,
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(activity.imageUrls.isNotEmpty ? activity.imageUrls[0] : ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 36, width: 36,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  shape: BoxShape.circle, 
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)]
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}