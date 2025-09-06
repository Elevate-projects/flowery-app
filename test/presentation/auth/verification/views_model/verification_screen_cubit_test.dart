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
  late MockGetResendCodeUsecase getResendCodeUseCase;
  late MockGetVerificationUsecase getVerificationUseCase;

  final resendCodeRequest = ResendCodeRequestEntity(
    email: 'moaazhassan559@gmail.com',
  );
  final verificationRequest = VerifyRequestEntity(resetCode: '123456');
  final resendExpectedResponse = ResendCodeResponseEntity(
    message: 'OTP Resented Successfully',
    info: 'Success',
  );
  final verificationExpectedResponse = const VerifyResponseEntity(
    message: 'Verification Successful',
    code: 200,
    status: 'Success',
  );

  final resendExpectedResult = Success<ResendCodeResponseEntity>(
    resendExpectedResponse,
  );
  final verificationExpectedResult = Success<VerifyResponseEntity>(
    verificationExpectedResponse,
  );
  setUp(() {
    getResendCodeUseCase = MockGetResendCodeUsecase();
    getVerificationUseCase = MockGetVerificationUsecase();

    provideDummy<Result<ResendCodeResponseEntity>>(resendExpectedResult);
    provideDummy<Result<VerifyResponseEntity>>(verificationExpectedResult);

    when(
      getResendCodeUseCase.execute(resendCodeRequest),
    ).thenAnswer((_) async => resendExpectedResult);
    when(
      getVerificationUseCase.execute(verificationRequest),
    ).thenAnswer((_) async => verificationExpectedResult);
  });
  blocTest<VerificationScreenCubit, VerificationScreenState>(
    'should emit [loading, success] when resend code is successful',
    build: () =>
        VerificationScreenCubit(getResendCodeUseCase, getVerificationUseCase),
    act: (cubit) =>
        cubit.doIntent(OnResendClickIntent(request: resendCodeRequest)),
    expect: () => [
      const VerificationScreenState(resendCodeStatus: Status.loading),
      const VerificationScreenState(
        resendCodeStatus: Status.loading,
        secondsRemaining: 30,
      ),
      const VerificationScreenState(
        resendCodeStatus: Status.success,
        secondsRemaining: 30,
      ),
    ],
  );
  blocTest<VerificationScreenCubit, VerificationScreenState>(
    'should emit [loading, success] when verification is successful',
    build: () =>
        VerificationScreenCubit(getResendCodeUseCase, getVerificationUseCase),
    act: (cubit) =>
        cubit.doIntent(OnVerificationIntent(request: verificationRequest)),
    expect: () => [
      const VerificationScreenState(verifyCodeStatus: Status.loading),
      const VerificationScreenState(verifyCodeStatus: Status.success),
    ],
  );
}
