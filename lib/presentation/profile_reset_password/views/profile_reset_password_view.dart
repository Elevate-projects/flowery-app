import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_cubit.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:flowery_app/presentation/profile_reset_password/views/widget/profile_reset_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileResetPasswordView extends StatelessWidget {
  const ProfileResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileResetPasswordCubit>(
      create: (context) =>
          getIt.get<ProfileResetPasswordCubit>()
            ..doIntent(intent: InitializedProfileResetPassword()),
      child: const Scaffold(
        body: SafeArea(child: ProfileResetPasswordViewBody()),
      ),
    );
  }
}
