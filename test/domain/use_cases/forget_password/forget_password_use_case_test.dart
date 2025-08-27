import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/forget_password/forget_password_repo.dart';
import 'package:flowery_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_case_test.mocks.dart';

 @GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockForgetPasswordRepo ;

  late ForgetPasswordUseCase
  forgetPasswordUseCase;
  setUp((){
    mockForgetPasswordRepo= MockForgetPasswordRepo();
    forgetPasswordUseCase= ForgetPasswordUseCase(mockForgetPasswordRepo);
  });

  test('should return Success with ForgetPasswordResponseEntity when repo returns valid response', ()async {
    final requestEntity =ForgetPasswordRequestEntity(email: "test@gmail.com");
    final responseEntity =ForgetPasswordResponseEntity(message: 'success',info: 'asa');
    var expectedResult =Success(responseEntity);
    provideDummy <Result<ForgetPasswordResponseEntity>>(expectedResult);
    when(mockForgetPasswordRepo.getForgetPassword(requestEntity)).thenAnswer((_)async =>expectedResult);

    var res = await forgetPasswordUseCase.call(requestEntity);
    verify(mockForgetPasswordRepo.getForgetPassword(requestEntity)).called(1);
    expect(res, isA<Success<ForgetPasswordResponseEntity>>());
    res as Success<ForgetPasswordResponseEntity>;
    expect(res.data.message, equals(responseEntity));

  });
}