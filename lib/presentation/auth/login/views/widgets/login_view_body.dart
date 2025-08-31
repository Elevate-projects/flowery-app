import 'package:flowery_app/presentation/auth/login/views/widgets/continue_as_guest_button.dart';
import 'package:flowery_app/presentation/auth/login/views/widgets/don_not_have_acc.dart';
import 'package:flowery_app/presentation/auth/login/views/widgets/login_button.dart';
import 'package:flowery_app/presentation/auth/login/views/widgets/login_form.dart';
import 'package:flowery_app/presentation/auth/login/views/widgets/remember_me_and_forget_pass_row.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current.loginStatus.isFailure || current.loginStatus.isSuccess,
      listener: (context, state) {
        if (state.loginStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.loginStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.loginStatus.isSuccess) {
          // Navigator.of(
          //   context,
          // ).pushReplacementNamed(RouteNames.homeBottomNavigation);
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                current.loginStatus.isLoading || current.loginStatus.isFailure,
            builder: (context, state) => AbsorbPointer(
              absorbing: state.loginStatus.isLoading,
              child: const Column(
                children: [
                  RSizedBox(height: 12),
                  LoginForm(),
                  RSizedBox(height: 15),
                  RememberMeAndForgetPassRow(),
                  RSizedBox(height: 63),
                  LoginButton(),
                  RSizedBox(height: 16),
                  ContinueAsGuestButton(),
                  RSizedBox(height: 16),
                  DonNotHaveAcc(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
