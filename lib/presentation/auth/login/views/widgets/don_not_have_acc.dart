import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonNotHaveAcc extends StatelessWidget {
  const DonNotHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppText.donNotHaveAccount,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              // Navigate to the signup screen
            },
            borderRadius: BorderRadius.circular(30.r),
            highlightColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.2),
            splashColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.2),
            child: RPadding(
              padding: const EdgeInsets.all(4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.signup,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
