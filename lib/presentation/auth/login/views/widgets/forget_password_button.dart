import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to the forget password screen
      },
      child: Text(
        AppText.forgetPassword,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).colorScheme.onSecondary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
