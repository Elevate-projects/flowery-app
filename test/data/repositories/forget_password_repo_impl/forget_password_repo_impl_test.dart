import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/data/repositories/forget_password_repo_impl/forget_password_repo_impl.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_repo_impl_test.mocks.dart';
@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
late MockForgetPasswordRemoteDataSource mockForgetPasswordRemoteDataSource;

late ForgetPasswordRepoImpl
   forgetPasswordRepoImpl;
   setUp((){
     mockForgetPasswordRemoteDataSource= MockForgetPasswordRemoteDataSource();
     forgetPasswordRepoImpl=ForgetPasswordRepoImpl(mockForgetPasswordRemoteDataSource);
   });

  test('should return Success with ForgetPasswordResponseEntity when remote data source returns valid response', ()async {
    final requestEntity =ForgetPasswordRequestEntity(email: "test@gmail.com");
    final responseEntity =ForgetPasswordResponseEntity(message: 'success',info: 'asa');
    var expectedResult =Success(responseEntity);
    provideDummy <Result<ForgetPasswordResponseEntity>>(expectedResult);
    when(mockForgetPasswordRemoteDataSource.getForgetPassword(requestEntity)).thenAnswer((_)async =>expectedResult);

    var res  =await forgetPasswordRepoImpl.getForgetPassword(requestEntity);
    verify(mockForgetPasswordRemoteDataSource.getForgetPassword(requestEntity)).called(1);
    expect(res, isA<Success<ForgetPasswordResponseEntity>>());
    res as Success<ForgetPasswordResponseEntity>;
    expect(res.data.message, equals(responseEntity));

  });
}