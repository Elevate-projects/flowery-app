import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/build_verification_form.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/common_widgets/loading_dialog.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  final String email = 'moaazhassan559@gmail.com';

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.password)),
      body: BlocListener<VerificationScreenCubit, VerificationScreenState>(
        listener: (context, state) {
          switch (state.resendCodeStatus) {
            case Status.initial:
              break;
            case Status.loading:
              showLoadingDialog(
                context,
                color: Theme.of(context).colorScheme.primary,
              );
            case Status.success:
              Navigator.pop(context);
              Loaders.showSuccessMessage(
                message: AppText.otpResendedSuccessfully,
                context: context,
              );
            case Status.error:
              Navigator.pop(context);
              Loaders.showErrorMessage(
                message: state.resendCodeError?.message ?? AppText.error,
                context: context,
              );
          }
          switch (state.verifyCodeStatus) {
            case Status.initial:
              break;
            case Status.loading:
              showLoadingDialog(
                context,
                color: Theme.of(context).colorScheme.primary,
              );
            case Status.success:
              Navigator.pop(context);
              setState(() => isError = false);
              Loaders.showSuccessMessage(
                message: AppText.verificationSuccess,
                context: context,
              );
            case Status.error:
              Navigator.pop(context);
              setState(() => isError = true);
              Loaders.showErrorMessage(
                message: state.verifyCodeError?.message ?? AppText.error,
                context: context,
              );

          }
        },
        child: BuildVerificationForm(email: widget.email, isError: isError),
      ),
    );
  }
}
