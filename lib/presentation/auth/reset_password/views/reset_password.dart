import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/reset_password/views/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/common_widgets/loading_dialog.dart';
import '../../../../utils/loaders/loaders.dart';
import '../view_model/reset_password_cubit.dart';
import '../view_model/reset_password_state.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.password),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          switch (state.status) {
            case Status.initial:
              break;
            case Status.loading:
              showLoadingDialog(
                context,
                color: Theme.of(context).colorScheme.primary,
              );
              break;
            case Status.success:
              Navigator.pop(context);
              Loaders.showSuccessMessage(
                message: AppText.passwordReseted,
                context: context,
              );
              break;
            case Status.error:
              Navigator.pop(context);
              Loaders.showErrorMessage(
                message: state.resetCodeError?.message ?? AppText.error,
                context: context,
              );
              break;
          }
        },
        child: BuildResetPasswordForm(email: widget.email),
      ),
    );
  }
}
