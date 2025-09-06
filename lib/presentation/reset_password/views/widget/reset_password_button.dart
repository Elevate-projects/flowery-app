import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ResetPasswordCubit>(context);
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state.resetPasswordStatus.isLoading) {
          return const CircularProgressIndicator();
        }
        return CustomElevatedButton(
          onPressed: () {
            controller.doIntent(intent: ResetPasswordRequested());
          },
          buttonTitle: AppText.resetPasswordUpdate,
        );
      },
    );
  }
}
