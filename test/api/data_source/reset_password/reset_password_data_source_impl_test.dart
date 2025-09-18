import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/reset_password/reset_password_data_source_impl.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient,Connectivity])
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
  test('when call reset password from apiClient it should success',()async {
    //Arrange
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
       ConnectionManager.connectivity = mockConnectivity;
       final resetDataSource = ResetPasswordDataSourceImpl(mockApiClient);
       final expectedResetPasswordResponse = ResetPasswordResponse(
        message: "success",
        bearerToken: "newToken",
       );
       final resetRequestPasswordEntity = ResetPasswordRequestEntity(
        password: "oldPassword",
        newPassword: "newPassword",
      );
      final expectedResetPasswordResponseEntity = Success(expectedResetPasswordResponse.toResetPasswordResponseEntity());
      provideDummy<Result<ResetPasswordResponseEntity>>(expectedResetPasswordResponseEntity);
        when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockApiClient.resetPassword(token: anyNamed("token"), entity: anyNamed("entity")))
      .thenAnswer((_) async => expectedResetPasswordResponse);
      //Act
      final result = await resetDataSource.resetPassword(entity: resetRequestPasswordEntity);
      final successResult = result as Success<ResetPasswordResponseEntity>;
      //Assert
      expect(result, isA<Success<ResetPasswordResponseEntity>>());
      verify(mockApiClient.resetPassword(token: anyNamed("token"), entity: anyNamed("entity"))).called(1);
      expect(expectedResetPasswordResponseEntity.data.message, equals(successResult.data.message));
      expect(expectedResetPasswordResponseEntity.data.bearerToken, equals(successResult.data.bearerToken));
  });
}