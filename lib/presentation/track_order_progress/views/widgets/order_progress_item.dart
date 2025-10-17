import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines_plus/timelines_plus.dart';

class OrderProgressItem extends StatelessWidget {
  const OrderProgressItem({
    super.key,
    required this.title,
    required this.isStateCompleted,
    required this.isLastItem,
    required this.progressDate,
  });
  final String title;
  final String progressDate;
  final bool isStateCompleted;
  final bool isLastItem;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TimelineTile(
      mainAxisExtent: 80.h,
      nodeAlign: TimelineNodeAlign.start,
      contents: Padding(
        padding: REdgeInsetsDirectional.only(start: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
            Text(
              progressDate,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
      node: TimelineNode(
        indicatorPosition: 0,
        indicator: isStateCompleted
            ? DotIndicator(color: theme.colorScheme.primary)
            : OutlinedDotIndicator(color: theme.colorScheme.shadow),
        endConnector: isLastItem
            ? null
            : SolidLineConnector(
                color: isStateCompleted
                    ? theme.colorScheme.primary
                    : theme.colorScheme.shadow,
                thickness: 1.sp,
              ),
      ),
    );
  }
}
