import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_states.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_view_model.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  final forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ForgetPasswordViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: AppColors.black),
          title: const Text(AppText.password),
        ),

        body: Builder(
          builder: (context) {
            final viewModel = context.read<ForgetPasswordViewModel>();
            return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
               listener: (BuildContext context, state) {
                switch (state) {
                  case ForgetPasswordInitial():
                    break;
                  case ForgetPasswordLoading():
                    const Center(child: CircularProgressIndicator());
                  case ForgetPasswordSuccess():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  case ForgetPasswordFailure():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 25.h),

                      Text(
                        AppText.forgetPassword2,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(height: 15.h),
                      const Text(
                        AppText.enterRegisteredEmail,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        label: AppText.email,
                        hintText: AppText.emailHint,
                        controller: emailController,
                        validator: (value) =>
                            Validations.emailValidation(email: value),
                      ),
                      SizedBox(height: 35.h),

                      CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                             context.read<ForgetPasswordViewModel>().doIntent(
                              OnConfirmEmailForgetPasswordClickIntent(
                                request: ForgetPasswordRequestEntity(
                                  email: emailController.text,
                                ),
                              ),
                            );
                          }
                        },
                        buttonTitle: AppText.confirmButton,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
