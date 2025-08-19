import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: InkWell(
        onTap: () {
          // Navigate to the forget password screen
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
          child: Text(
            AppText.forgetPassword,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.onSecondary,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
