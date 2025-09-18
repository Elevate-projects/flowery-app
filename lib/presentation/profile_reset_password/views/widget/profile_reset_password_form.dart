import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_cubit.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileResetPasswordForm extends StatelessWidget {
  const ProfileResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ProfileResetPasswordCubit>(context);
    return BlocBuilder<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      builder: (context, state) {
        return Form(
          key: controller.resetPasswordFormKey,
          autovalidateMode: state.autoValidateMode,
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.currentPasswordController,
                label: AppText.profileCurrentPasswordLabel.tr(),
                hintText: AppText.profileCurrentPasswordHint.tr(),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validations.passwordValidation(password: value),
                onChanged: (_) {
                  controller.doIntent(intent: IsTypingIntent());
                },
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.newPasswordController,
                label: AppText.profileNewPasswordLabel.tr(),
                hintText: AppText.profileNewPasswordHint.tr(),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validations.passwordValidation(password: value),
                onChanged: (_) {
                  controller.doIntent(intent: IsTypingIntent());
                },
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.confirmPasswordController,
                label: AppText.profileConfirmPasswordLabel.tr(),
                hintText: AppText.profileConfirmPasswordHintReset.tr(),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) => Validations.confirmPasswordValidation(
                  conformPassword: value,
                  password: controller.newPasswordController.text,
                ),
                onChanged: (_) {
                  controller.doIntent(intent: IsTypingIntent());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
