import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(AppText.login, style: theme.textTheme.titleLarge),
    );
  }
}
