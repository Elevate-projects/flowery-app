
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/repositories/forget_password/forget_password_repo.dart';
import 'package:flowery_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_case_test.mocks.dart';


@GenerateMocks([ForgetPasswordRepo])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  forgetPassword from dataSource ', () async {
    final mockRepo = MockForgetPasswordRepo();
    final ForgetPasswordUseCase useCase = ForgetPasswordUseCase(mockRepo);


    final request = const ForgetPasswordRequestEntity(
      email: 'Peter1@gmail.com',
    );
    final expectedResponse = const ForgetPasswordEntity(
      message: 'Forget password test',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ForgetPasswordEntity>>(expectedResult);

    when(
      mockRepo.forgetPassword(request),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.call(request);

    verify(mockRepo.forgetPassword(request)).called(1);

    expect(result, isA<Success<ForgetPasswordEntity>>());

    result as Success<ForgetPasswordEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
