import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/register_app_bar.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) =>
          getIt.get<RegisterCubit>()
            ..doIntent(intent: InitializedRegisterIntent()),
      child: const Scaffold(appBar: RegisterAppBar(), body:  RegisterViewBody()),
    );
  }
}
