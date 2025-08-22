import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:flowery_app/domain/use_cases/reset_password/reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateMocks([ResetPasswordRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    var mockRepo = MockResetPasswordRepository();
    GetResetPasswordUsecase usecase = GetResetPasswordUsecase(mockRepo);

    var resetCodeRequest = ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: 'newPassword123',
    );
    var expectedResponse = ResetPasswordResponseEntity(
      token: 'newlyGeneratedToken',
      code: 200,
      message: 'Password reset successfully',
    );
    var expectedResult = Success(expectedResponse);
    provideDummy<Result<ResetPasswordResponseEntity>>(expectedResult);

    when(
      mockRepo.resetPassword(resetCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    var result = await usecase.execute(resetCodeRequest);

    verify(mockRepo.resetPassword(resetCodeRequest)).called(1);

    expect(result, isA<Success<ResetPasswordResponseEntity>>());

    result as Success<ResetPasswordResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
