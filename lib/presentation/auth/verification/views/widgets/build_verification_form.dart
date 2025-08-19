import 'dart:async';

import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/pin_code_textfiled.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/resend_code_row.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/title_and_subtitle_of_verification.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../../../domain/entities/verification/request/verify_requset.dart';
import '../../../../../utils/loaders/loaders.dart';
import '../../views_model/verification_screen_intent.dart';

class BuildVerificationForm extends StatefulWidget {
  const BuildVerificationForm({
    super.key,
    required this.email,
    required this.isError,
  });

  final String email;
  final bool isError;

  @override
  State<BuildVerificationForm> createState() => _BuildVerificationFormState();
}

class _BuildVerificationFormState extends State<BuildVerificationForm> {
  int _secondsRemaining = 0;
  Timer? _timer;
  TextEditingController verificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleAndSubtitleOfVerification(),
            SizedBox(height: 30.h),
            PinCodeTextFiledWidget(
              isError: widget.isError,
              verificationController: verificationController,
              onCompleted: (value) {
                BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                  OnVerificationIntent(
                    request: VerifyRequsetEntity(
                      resetCode: verificationController.text,
                    ),
                  ),
                );
              },
              onSubmitted: (value) {
                if (value.isEmpty || value.length < 6) {
                  Loaders.showErrorMessage(
                    message: AppText.enter6DigitCode,
                    context: context,
                  );
                  return;
                }
                BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                  OnVerificationIntent(
                    request: VerifyRequsetEntity(resetCode: value),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Visibility(
              visible: _secondsRemaining > 0,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Text(
                AppText.resendAvaiableStatement + '$_secondsRemaining' + 's',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ),
            SizedBox(height: 20.h),
            ResendCodeRow(
              isDisabled: _secondsRemaining > 0,
              onResend: () {
                BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                  OnResendClickIntent(
                    request: ResendCodeRequestEntity(email: widget.email),
                  ),
                );
                _startTimer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
