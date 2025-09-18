import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_cubit.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileResetPasswordButton extends StatelessWidget {
  const ProfileResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ProfileResetPasswordCubit>(context);
    return BlocBuilder<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      builder: (context, state) {
        if (state.resetPasswordStatus.isLoading) {
          return const LoadingButton();
        }
        return CustomElevatedButton(
          onPressed:state.isTyping ? () async {
            controller.doIntent(intent: ProfileResetPasswordRequested());
          }: null,
          buttonTitle: AppText.resetPasswordUpdate.tr(),
        );
      },
    );
  }
}
