import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) {
        return current is RegisterLoadingState ||
            current is RegisterFailureState;
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const LoadingButton();
        } else {
          return CustomElevatedButton(
            onPressed: () async {
              await controller.doIntent(intent: RegisterWithDataIntent());
            },
            buttonTitle: AppText.signup,
          );
        }
      },
    );
  }
}
