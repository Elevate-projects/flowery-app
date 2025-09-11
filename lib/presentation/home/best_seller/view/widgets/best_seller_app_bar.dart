import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BestSellerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.bestSellerAppbar.tr(), style: theme.textTheme.headlineMedium),
          SizedBox(height: 4.h),
          Text(
            AppText.bestSellerAppbarHint.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
