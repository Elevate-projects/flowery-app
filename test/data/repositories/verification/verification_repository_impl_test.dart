import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_app/data/repositories/verification/verification_repository_impl.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_repository_impl_test.mocks.dart';

@GenerateMocks([VerificationDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  verification from dataSource ', () async {
    var mockDataSource = MockVerificationDataSource();
    VreificationRepositoryImpl repo = VreificationRepositoryImpl(
      mockDataSource,
    );

    var verifyRequest = VerifyRequsetEntity(resetCode: '123456');

    var expectedResponse = VerifyResponseEntity(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    var expectedResult = Success(expectedResponse);

    provideDummy<Result<VerifyResponseEntity>>(expectedResult);

    when(
      mockDataSource.verify(verifyRequest),
    ).thenAnswer((_) async => expectedResult);

    var result = await repo.verify(verifyRequest);

    verify(mockDataSource.verify(verifyRequest)).called(1);

    expect(result, isA<Success<VerifyResponseEntity>>());

    result as Success<VerifyResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
