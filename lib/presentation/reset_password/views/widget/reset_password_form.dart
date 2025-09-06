import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = BlocProvider.of<ResetPasswordCubit>(context);
    return Form(
      child: Column(
        children: [
         CustomTextFormField(
          controller:  controller.currentPasswordController,
                label: AppText.currentPasswordLabel,
                hintText: AppText.currentPasswordHint,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller:  controller.newPasswordController,
                label: AppText.newPasswordLabel,
                hintText: AppText.newPasswordHint,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                          Validations.passwordValidation(password: value),
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                label: AppText.confirmPasswordLabel,
                  hintText: AppText.confirmPasswordHintReset,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) =>
                          Validations.confirmPasswordValidation(
                            conformPassword: value,
                            password: controller.newPasswordController.text,
                          )
              ),
              
        ],
      ),
    );
  }
}