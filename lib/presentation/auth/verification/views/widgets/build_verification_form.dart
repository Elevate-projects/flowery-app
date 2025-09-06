import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/pin_code_textfiled.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/resend_code_row.dart';
import 'package:flowery_app/presentation/auth/verification/views/widgets/title_and_subtitle_of_verification.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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
  TextEditingController verificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleAndSubtitleOfVerification(),
                SizedBox(height: 30.h),
                PinCodeTextFiledWidget(
                  isError: widget.isError,
                  verificationController: verificationController,
                  onCompleted: (value) {
                    BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                      OnVerificationIntent(
                        request: VerifyRequestEntity(
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
                        request: VerifyRequestEntity(resetCode: value),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: state.secondsRemaining > 0,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text(
                    '${AppText.resendAvaiableStatement}${state.secondsRemaining}s',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                  ),
                ),
                SizedBox(height: 20.h),
                ResendCodeRow(
                  isDisabled: state.secondsRemaining > 0,
                  onResend: () {
                    BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                      OnResendClickIntent(
                        request: ResendCodeRequestEntity(email: widget.email),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
