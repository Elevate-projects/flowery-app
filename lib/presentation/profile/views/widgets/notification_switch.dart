import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProfileNavigationItem(
      isIconWithTitle: false,
      titleWidget: Row(
        children: [
          RSizedBox(
            height: 20,
            width: 42,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Switch.adaptive(
                value: true,
                onChanged: (value) {},
                padding: EdgeInsets.zero,
                activeColor: theme.colorScheme.secondary,
                activeTrackColor: theme.colorScheme.primary,
              ),
            ),
          ),
          const RSizedBox(width: 8),
          Flexible(
            child: Text(
              AppText.notification,
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      prefixIconPath: AppIcons.location,
    );
  }
}
