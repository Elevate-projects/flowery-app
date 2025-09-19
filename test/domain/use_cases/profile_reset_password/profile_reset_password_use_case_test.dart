import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:flowery_app/domain/use_cases/profile_reset_password/profile_reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_reset_password_use_case_test.mocks.dart';
@GenerateMocks([ProfileResetPasswordRepository])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
 test('when call resetPassword from ProfileResetPasswordUseCase return success',()async{
  //Arrange
   final mockRepository=MockProfileResetPasswordRepository();
  final resetPasswordUseCase =ProfileResetPasswordUseCase(repository: mockRepository);
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
      when(mockRepository.resetPassword(entity: anyNamed("entity")))
          .thenAnswer((_) async => expectedResult);
          //Act
          final result = await resetPasswordUseCase(entity: resetRequestPasswordEntity);
          final successResult = result as Success<ProfileResetPasswordResponseEntity>;
          //Assert
          expect(result, isA<Success<ProfileResetPasswordResponseEntity>>());
          verify(mockRepository.resetPassword(entity: anyNamed("entity"))).called(1);
          expect(expectedResetPasswordResponseEntity.message, equals(successResult.data.message));
          expect(expectedResetPasswordResponseEntity.bearerToken, equals(successResult.data.bearerToken));
 });


}