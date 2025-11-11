import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderProgressAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TrackOrderProgressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomAppBar(
      centerTitle: false,
      isTitleWidget: true,
      titleWidget: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const CustomBackArrow(),
            Text(
              AppText.trackOrder.tr(),
              style: theme.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
