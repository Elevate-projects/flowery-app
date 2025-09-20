import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:flowery_app/data/repositories/profile_reset_password/profile_reset_password_repository_impl.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_reset_password_respository_impl_test.mocks.dart';
@GenerateMocks([ProfileResetPasswordDataSource])
void main(){
  test('when call resetpassword from ProfileResetPasswordRepositoryImpl return success',()async{
  //Arrange
  final mockDataSource=MockProfileResetPasswordDataSource();
  final resetPasswordRepository =ProfileResetPasswordRepositoryImpl(mockDataSource);
   final expectedResetPasswordResponseEntity = ProfileResetPasswordResponseEntity(
        message: "success",
        bearerToken: "newToken",
       );
       final resetRequestPasswordEntity = ProfileResetPasswordRequestEntity(
        password: "oldPassword",
        newPassword: "newPassword",
      );
      final expectedResult = Success(expectedResetPasswordResponseEntity);
      provideDummy<Result<ProfileResetPasswordResponseEntity>>(expectedResult);
      when(mockDataSource.resetPassword(entity: anyNamed("entity")))
          .thenAnswer((_) async => expectedResult);
          //Act
          final result = await resetPasswordRepository.resetPassword(entity: resetRequestPasswordEntity);
          final successResult = result as Success<ProfileResetPasswordResponseEntity>;
          //Assert
          expect(result, isA<Success<ProfileResetPasswordResponseEntity>>());
          verify(mockDataSource.resetPassword(entity: anyNamed("entity"))).called(1);
          expect(expectedResetPasswordResponseEntity.message, equals(successResult.data.message));
          expect(expectedResetPasswordResponseEntity.bearerToken, equals(successResult.data.bearerToken));

  });
}