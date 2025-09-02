import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final controller = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) {
        return current.registerState.isLoading ||
            current.registerState.isFailure ||
            current is EnableAutoValidateModeState ||
            current is ChangePasswordObscureState ||
            current is ChangeConfirmPasswordObscureState;
      },
      builder: (context, state) {
        return Form(
          key: controller.registerFormKey,
          autovalidateMode: controller.autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.firstNameController,
                      label: AppText.firstName,
                      hintText: AppText.firstNameHint,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validations.validateEmptyText(value),
                    ),
                  ),
                  const RSizedBox(width: 17),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.lastNameController,
                      label: AppText.lastName,
                      hintText: AppText.lastNameHint,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validations.validateEmptyText(value),
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.emailController,
                label: AppText.email,
                hintText: AppText.emailHint,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validations.emailValidation(email: value),
              ),
              const RSizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.passwordController,
                      label: AppText.password,
                      hintText: AppText.passwordHint,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validations.passwordValidation(password: value),
                      obscureText: state is ChangePasswordObscureState
                          ? state.isObscure
                          : true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.doIntent(
                            intent: TogglePasswordVisibilityIntent(),
                          );
                        },
                        icon: Icon(
                          (state is ChangePasswordObscureState
                                  ? state.isObscure
                                  : true)
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: theme.colorScheme.onSecondary,
                          size: 22.r,
                        ),
                      ),
                    ),
                  ),
                  const RSizedBox(width: 17),
                  Expanded(
                    child: CustomTextFormField(
                      controller: controller.confirmPasswordController,
                      label: AppText.confirmPassword,
                      hintText: AppText.confirmPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: (value) =>
                          Validations.confirmPasswordValidation(
                            conformPassword: value,
                            password: controller.passwordController.text,
                          ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.doIntent(
                            intent: ToggleConfirmPasswordVisibilityIntent(),
                          );
                        },
                        icon: Icon(
                          (state is ChangeConfirmPasswordObscureState
                                  ? state.isObscure
                                  : true)
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: theme.colorScheme.onSecondary,
                          size: 22.r,
                        ),
                      ),
                      obscureText: state is ChangeConfirmPasswordObscureState
                          ? state.isObscure
                          : true,
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 24),
              CustomTextFormField(
                controller: controller.phoneNumberController,
                label: AppText.phoneNumber,
                hintText: AppText.phoneNumberHint,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    Validations.phoneValidation(phoneNumber: value),
              ),
              const RSizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
