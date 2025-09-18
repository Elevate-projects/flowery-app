import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/data/repositories/reset_password/reset_password_repository_impl.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_respository_impl_test.mocks.dart';
@GenerateMocks([ResetPasswordDataSource])
void main(){
  test('when call resetpassword from ResetPasswordRepositoryImpl return success',()async{
  //Arrange
  final mockDataSource=MockResetPasswordDataSource();
  final resetPasswordRepository =ResetPasswordRepositoryImpl(mockDataSource);
   final expectedResetPasswordResponseEntity = ResetPasswordResponseEntity(
        message: "success",
        bearerToken: "newToken",
       );
       final resetRequestPasswordEntity = ResetPasswordRequestEntity(
        password: "oldPassword",
        newPassword: "newPassword",
      );
      final expectedResult = Success(expectedResetPasswordResponseEntity);
      provideDummy<Result<ResetPasswordResponseEntity>>(expectedResult);
      when(mockDataSource.resetPassword(entity: anyNamed("entity")))
          .thenAnswer((_) async => expectedResult);
          //Act
          final result = await resetPasswordRepository.resetPassword(entity: resetRequestPasswordEntity);
          final successResult = result as Success<ResetPasswordResponseEntity>;
          //Assert
          expect(result, isA<Success<ResetPasswordResponseEntity>>());
          verify(mockDataSource.resetPassword(entity: anyNamed("entity"))).called(1);
          expect(expectedResetPasswordResponseEntity.message, equals(successResult.data.message));
          expect(expectedResetPasswordResponseEntity.bearerToken, equals(successResult.data.bearerToken));

  });
}