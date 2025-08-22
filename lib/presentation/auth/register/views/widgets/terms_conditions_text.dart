import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';


class TermsConditionsText extends StatelessWidget {
  const TermsConditionsText({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FittedBox(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text:AppText.createAnAccountYouAgree,
              style: theme.textTheme.labelMedium
            ),
            TextSpan(
              text: AppText.termsAndConditions,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}