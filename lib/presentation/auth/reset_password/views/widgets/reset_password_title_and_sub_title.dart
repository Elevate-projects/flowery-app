import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';

class ResetPasswordTitleAndSubTitle extends StatelessWidget {
  const ResetPasswordTitleAndSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(AppText.resetPasswordTitle, style: theme.headlineSmall),
        SizedBox(height: 15.h),
        Text(
          textAlign: TextAlign.center,
          AppText.resetPasswordSubTitle,
          style: theme.bodyLarge?.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
