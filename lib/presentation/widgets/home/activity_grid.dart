import 'package:flutter/material.dart';
import 'activity_card_horizontal.dart';
import '../../../data/models/activity_model.dart';
import '../../pages/activity/activity_detail_page.dart';

class ActivityGrid extends StatelessWidget {
  final List<ActivityModel> activities;

  const ActivityGrid({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailPage(activity: activity),
              ),
            );
          },
          child: ActivityCardHorizontal(activity: activity),
        );
      },
    );
  }
}