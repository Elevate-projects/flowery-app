import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/repositories/resend_code/resend_code.dart';
import 'package:flowery_app/domain/use_cases/resend_code/resend_code_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'resend_code_usecase_test.mocks.dart';

@GenerateMocks([ResendCodeRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockResendCodeRepository();
    final GetResendCodeUsecase useCase = GetResendCodeUsecase(mockRepo);

    final resendCodeRequest = ResendCodeRequestEntity(
      email: 'moaazhassan559@gmail.com',
    );
    final expectedResponse = ResendCodeResponseEntity(
      info: 'Please check your email for the verification code.',
      message: 'Verification code sent successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ResendCodeResponseEntity>>(expectedResult);

    when(
      mockRepo.resendCode(resendCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(resendCodeRequest);

    verify(mockRepo.resendCode(resendCodeRequest)).called(1);

    expect(result, isA<Success<ResendCodeResponseEntity>>());

    result as Success<ResendCodeResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
