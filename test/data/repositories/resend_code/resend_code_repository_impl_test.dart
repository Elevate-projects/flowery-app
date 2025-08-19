import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/resend_code/resend_code_data_source.dart';
import 'package:flowery_app/data/repositories/resend_code/resend_code_repository_impl.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'resend_code_repository_impl_test.mocks.dart';

@GenerateMocks([ResendCodeDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    var mockDataSource = MockResendCodeDataSource();
    ResendCodeRepositoryImpl repo = ResendCodeRepositoryImpl(mockDataSource);

    var resendCodeRequest = ResendCodeRequestEntity(
      email: 'moaazhassan559@gmail.com',
    );
    var expectedResponse = ResendCodeResponseEntity(
      info: 'Please check your email for the verification code.',
      message: 'Verification code sent successfully',
    );
    var expectedResult = Success(expectedResponse);
    provideDummy<Result<ResendCodeResponseEntity>>(expectedResult);

    when(
      mockDataSource.resendCode(resendCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    var result = await repo.resendCode(resendCodeRequest);

    verify(mockDataSource.resendCode(resendCodeRequest)).called(1);

    expect(result, isA<Success<ResendCodeResponseEntity>>());

    result as Success<ResendCodeResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
