import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueAsGuestButton extends StatelessWidget {
  const ContinueAsGuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = BlocProvider.of<LoginCubit>(context);
    return CustomElevatedButton(
      onPressed: () {
        controller.doIntent(intent: LoginAsGuestIntent());
      },
      buttonTitle: AppText.continueAsGuest,
      titleStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.shadow,
      ),
      borderColor: theme.colorScheme.shadow,
      backgroundColor: theme.colorScheme.secondary,
    );
  }
}
