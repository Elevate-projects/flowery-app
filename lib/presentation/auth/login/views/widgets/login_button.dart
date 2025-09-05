import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          current.loginStatus.isLoading || current.loginStatus.isFailure,
      builder: (context, state) => state.loginStatus.isLoading
          ? const LoadingButton()
          : CustomElevatedButton(
              onPressed: () async => await controller.doIntent(
                intent: LoginWithEmailAndPasswordIntent(),
              ),
              buttonTitle: AppText.login,
            ),
    );
  }
}
