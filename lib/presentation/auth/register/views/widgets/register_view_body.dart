import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/have_account_login_text.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/radio_gender_row.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/register_button.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/register_form.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/terms_conditions_text.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final controller = BlocProvider.of<RegisterCubit>(context);
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) {
        return
            current.registerState.isSuccess ||
            current.registerState.isFailure ||
            current is AlreadyHaveAccountState;
      },
      listener: (context, state) {
        if (state.registerState.isFailure) {
          Loaders.showErrorMessage(
            message: state.registerState.error?.message ?? "",
            context: context,
          );
        } else if (state.registerState.isSuccess) {
          // navigate to homescreen
          //nav to login
          Navigator.pushReplacementNamed(context, '/login');
        } else if (state is AlreadyHaveAccountState) {
          // navigate to login screen
          Loaders.showSuccessMessage(
            message: "You already have an account",
            context: context,
          );
        }
      },
      child:  SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) {
              return current.registerState.isLoading ||
                     current.registerState.isFailure;
            },
            builder: (context, state) {
              return const Column(
                children:  [
                  RSizedBox(height: 24),
                  RegisterForm(),
                  RegisterGenderRow(),
                  RSizedBox(height: 24),
                  TermsConditionsText(),
                  RSizedBox(height: 48),
                  RegisterButton(),
                  RSizedBox(height: 16),
                  HaveAccountLoginText(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
