import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/auth/reset_password/views/widgets/reset_password_title_and_sub_title.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildResetPasswordForm extends StatelessWidget {
  const BuildResetPasswordForm({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final passwordConfirmationController = TextEditingController();

    return Padding(
      padding: REdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ResetPasswordTitleAndSubTitle(),
            SizedBox(height: 30.h),
            CustomTextFormField(
              label: AppText.password,
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.passwordHint,
              validator: (value) =>
                  Validations.passwordValidation(password: value),
            ),
            SizedBox(height: 25.h),
            CustomTextFormField(
              label: AppText.confirmPassword,
              controller: passwordConfirmationController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.confirmPasswordHint,
              validator: (value) => Validations.confirmPasswordValidation(
                password: passwordController.text,
                conformPassword: value,
              ),
            ),
            SizedBox(height: 50.h),
            CustomElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<ResetPasswordCubit>(context).doIntent(
                    OnResetPasswordIntent(
                      request: ResetPasswordRequestEntity(
                        email: email,
                        newPassword: passwordConfirmationController.text,
                      ),
                    ),
                  );
                }
              },
              buttonTitle: AppText.continueWord,
            ),
          ],
        ),
      ),
    );
  }
}
