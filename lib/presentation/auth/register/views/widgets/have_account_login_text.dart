import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaveAccountLoginText extends StatelessWidget {
  const HaveAccountLoginText({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = BlocProvider.of<RegisterCubit>(context);
    return FittedBox(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppText.alreadyHaveAnAccount.tr(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
            TextSpan(
              text: AppText.login.tr(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: theme.colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.doIntent(intent: AlreadyHaveAccountIntent());
                },
            ),
          ],
        ),
      ),
    );
  }
}
