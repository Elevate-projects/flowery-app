import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flowery_app/domain/repositories/verification/verification_repository.dart';
import 'package:flowery_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_usecase_test.mocks.dart';

@GenerateMocks([VerificationRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockVerificationRepository();
    final GetVerificationUsecase useCase = GetVerificationUsecase(mockRepo);

    final verifyRequest = VerifyRequestEntity(resetCode: '123456');

    final expectedResponse = const VerifyResponseEntity(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    final expectedResult = Success(expectedResponse);

    provideDummy<Result<VerifyResponseEntity>>(expectedResult);

    when(
      mockRepo.verify(verifyRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(verifyRequest);

    verify(mockRepo.verify(verifyRequest)).called(1);

    expect(result, isA<Success<VerifyResponseEntity>>());

    result as Success<VerifyResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}