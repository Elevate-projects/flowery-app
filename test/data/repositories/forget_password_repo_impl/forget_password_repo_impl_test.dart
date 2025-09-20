
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/data/repositories/forget_password_repo_impl/forget_password_repo_impl.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_repo_impl_test.mocks.dart';


@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('should return Success<ForgetPasswordEntity> and call dataSource when API call succeeds ', () async {
    final mockDataSource = MockForgetPasswordRemoteDataSource();
    final ForgetPasswordRepoImpl repo = ForgetPasswordRepoImpl(
      mockDataSource,
    );

    final request = const ForgetPasswordRequestEntity(
      email: 'Peter1@gmail.com',
    );
    final expectedResponse = const ForgetPasswordEntity(
      message: 'Forget password test',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ForgetPasswordEntity>>(expectedResult);

    when(
      mockDataSource.forgetPassword(request),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.forgetPassword(request);

    verify(mockDataSource.forgetPassword(request)).called(1);

    expect(result, isA<Success<ForgetPasswordEntity>>());

    result as Success<ForgetPasswordEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}

