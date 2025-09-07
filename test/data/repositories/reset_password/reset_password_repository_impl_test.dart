import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/data/repositories/reset_password/reset_password_repository_impl.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_repository_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resetCode from dataSource ', () async {
    final mockDataSource = MockResetPasswordDataSource();
    final ResetPasswordRepositoryImpl repo = ResetPasswordRepositoryImpl(
      mockDataSource,
    );

    final resetCodeRequest = ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: '12345678',
    );
    final expectedResponse = ResetPasswordResponseEntity(
      token: 'sample_token',
      message: 'Password reset successfully',
      code: 200,
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ResetPasswordResponseEntity>>(expectedResult);

    when(
      mockDataSource.resetPassword(resetCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.resetPassword(resetCodeRequest);

    verify(mockDataSource.resetPassword(resetCodeRequest)).called(1);

    expect(result, isA<Success<ResetPasswordResponseEntity>>());

    result as Success<ResetPasswordResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}