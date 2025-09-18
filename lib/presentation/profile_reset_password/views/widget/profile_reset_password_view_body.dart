import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_cubit.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_state.dart';
import 'package:flowery_app/presentation/profile_reset_password/views/widget/profile_reset_password_app_bar.dart';
import 'package:flowery_app/presentation/profile_reset_password/views/widget/profile_reset_password_button.dart';
import 'package:flowery_app/presentation/profile_reset_password/views/widget/profile_reset_password_form.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileResetPasswordViewBody extends StatelessWidget {
  const ProfileResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      listener: (context, state) {
        if (state.resetPasswordStatus.isSuccess) {
          Loaders.showSuccessMessage(message: "Password reset successful", context: context);
          // logout the user or navigate to login screen
          Navigator.of(context).pushReplacementNamed('/login');
        } else if (state.resetPasswordStatus.isFailure) {
          Loaders.showErrorMessage(message: state.resetPasswordStatus.error?.message ?? "Unknown error", context: context);
        }
      },
      builder: (context, state) {
        return const SafeArea(
          child: RPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Expanded(
              child: Column(
                children: [
                  ProfileResetPasswordAppBar(),
                  RSizedBox(height: 32),
                  ProfileResetPasswordForm(),
                  RSizedBox(height: 48),
                  ProfileResetPasswordButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
