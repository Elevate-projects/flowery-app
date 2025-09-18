import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:flowery_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';
@GenerateMocks([ResetPasswordRepository])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
 test('when call resetPassword from ResetPasswordUseCase return success',()async{
  //Arrange
   final mockRepository=MockResetPasswordRepository();
  final resetPasswordUseCase =ResetPasswordUseCase(repository: mockRepository);
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
      when(mockRepository.resetPassword(entity: anyNamed("entity")))
          .thenAnswer((_) async => expectedResult);
          //Act
          final result = await resetPasswordUseCase(entity: resetRequestPasswordEntity);
          final successResult = result as Success<ResetPasswordResponseEntity>;
          //Assert
          expect(result, isA<Success<ResetPasswordResponseEntity>>());
          verify(mockRepository.resetPassword(entity: anyNamed("entity"))).called(1);
          expect(expectedResetPasswordResponseEntity.message, equals(successResult.data.message));
          expect(expectedResetPasswordResponseEntity.bearerToken, equals(successResult.data.bearerToken));
 });


}