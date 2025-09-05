import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/core/router/route_names.dart';
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


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider (
      create: (context) => getIt.get<ForgetPasswordViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: AppColors.black),
          title: const Text(AppText.password),
        ),

        body: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
          listener: (context, state) {
            switch (state) {
              case ForgetPasswordInitial():
                break;
              case ForgetPasswordSuccess():
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)),);
               Navigator.of(context).pushNamed(RouteNames.verification);
               break;
              case ForgetPasswordFailure():
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              default:
                break;
            }
          },

          builder: (context, state) {
            final viewModel = context.read<ForgetPasswordViewModel>();

            if (state is ForgetPasswordLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key:viewModel.formKey,
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
                      controller:viewModel.emailController,
                      validator: (value) =>
                          Validations.emailValidation(email: value),
                    ),
                    SizedBox(height: 35.h),

                    CustomElevatedButton(
                      onPressed: () {
                        if (viewModel.formKey.currentState!.validate()) {
                          context.read<ForgetPasswordViewModel>().doIntent(
                            OnConfirmEmailForgetPasswordClickIntent(
                              request: ForgetPasswordRequestEntity(
                                email: viewModel.emailController.text,
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
            );
          },
        ),
      ),
    );
  }
}
