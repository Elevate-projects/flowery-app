import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/build_verification_form.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flowery_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  final String email = 'moaazhassan559@gmail.com';

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  void initState() {
    BlocProvider.of<VerificationScreenCubit>(context).doIntent(OnStartTimer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppText.password)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VerificationScreenCubit, VerificationScreenState>(
            listenWhen: (prev, curr) =>
                prev.resendCodeStatus != curr.resendCodeStatus,
            listener: (context, state) {
              switch (state.resendCodeStatus) {
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
                    message: AppText.otpResendedSuccessfully,
                    context: context,
                  );
                  break;
                case Status.error:
                  Navigator.pop(context);
                  Loaders.showErrorMessage(
                    message: state.resendCodeError?.message ?? AppText.error,
                    context: context,
                  );
                  break;
              }
            },
          ),
          BlocListener<VerificationScreenCubit, VerificationScreenState>(
            listenWhen: (prev, curr) =>
                prev.verifyCodeStatus != curr.verifyCodeStatus,
            listener: (context, state) {
              switch (state.verifyCodeStatus) {
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
                    message: AppText.verificationSuccess,
                    context: context,
                  );
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.resetPassword,
                      arguments: widget.email,
                    );
                  });
                  break;
                case Status.error:
                  Navigator.pop(context);
                  Loaders.showErrorMessage(
                    message: state.verifyCodeError?.message ?? AppText.error,
                    context: context,
                  );
                  break;
              }
            },
          ),
        ],
        child: BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
          builder: (context, state) {
            return BuildVerificationForm(
              email: widget.email,
              isError: state.isError,
            );
          },
        ),
      ),
    );
  }
}
