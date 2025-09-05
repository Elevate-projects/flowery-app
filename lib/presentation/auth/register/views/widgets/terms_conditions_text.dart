import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TermsConditionsText extends StatelessWidget {
  const TermsConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FittedBox(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppText.createAnAccountYouAgree.tr(),
              style: theme.textTheme.labelMedium,
            ),
            TextSpan(
              text: AppText.termsAndConditions.tr(),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}