import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flowery_app/domain/use_cases/resend_code/resend_code_usecase.dart';
import 'package:flowery_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_screen_cubit_test.mocks.dart';

@GenerateMocks([GetResendCodeUsecase, GetVerificationUsecase])
void main() {
  late MockGetResendCodeUsecase getResendCodeUsecase;
  late MockGetVerificationUsecase getVerificationUsecase;

  var resendCodeRequest = ResendCodeRequestEntity(
    email: 'moaazhassan559@gmail.com',
  );
  var verificationRequest = VerifyRequsetEntity(resetCode: '123456');
  var resendExpectedResponse = ResendCodeResponseEntity(
    message: 'OTP Resended Successfully',
    info: 'Success',
  );
  var verificationExpectedResponse = VerifyResponseEntity(
    message: 'Verification Successful',
    code: 200,
    status: 'Success',
  );

  var resendExpectedResult = Success<ResendCodeResponseEntity>(
    resendExpectedResponse,
  );
  var verifyationExpectedResult = Success<VerifyResponseEntity>(
    verificationExpectedResponse,
  );
  setUp(() {
    getResendCodeUsecase = MockGetResendCodeUsecase();
    getVerificationUsecase = MockGetVerificationUsecase();

    provideDummy<Result<ResendCodeResponseEntity>>(resendExpectedResult);
    provideDummy<Result<VerifyResponseEntity>>(verifyationExpectedResult);

    when(
      getResendCodeUsecase.execute(resendCodeRequest),
    ).thenAnswer((_) async => resendExpectedResult);
    when(
      getVerificationUsecase.execute(verificationRequest),
    ).thenAnswer((_) async => verifyationExpectedResult);
  });
  blocTest<VerificationScreenCubit, VerificationScreenState>(
    'should emit [loading, success] when resend code is successful',
    build: () =>
        VerificationScreenCubit(getResendCodeUsecase, getVerificationUsecase),
    act: (cubit) =>
        cubit.doIntent(OnResendClickIntent(request: resendCodeRequest)),
    expect: () => [
      const VerificationScreenState(resendCodeStatus: Status.loading),
      const VerificationScreenState(resendCodeStatus: Status.success),
    ],
  );
  blocTest<VerificationScreenCubit, VerificationScreenState>(
    'should emit [loading, success] when verification is successful',
    build: () =>
        VerificationScreenCubit(getResendCodeUsecase, getVerificationUsecase),
    act: (cubit) =>
        cubit.doIntent(OnVerificationIntent(request: verificationRequest)),
    expect: () => [
      const VerificationScreenState(verifyCodeStatus: Status.loading),
      const VerificationScreenState(verifyCodeStatus: Status.success),
    ],
  );
}
