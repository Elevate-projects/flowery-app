import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/forget_password/remote_data_source/forget_password_remote_data_source_impl.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient,Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockConnectivity mockConnectivity ;
  late MockApiClient mockApiClient;
  late ForgetPasswordRemoteDataSourceImpl forgetPasswordRemoteDataSourceImpl;
  setUp(() {
    mockApiClient = MockApiClient();
    mockConnectivity =MockConnectivity();
    forgetPasswordRemoteDataSourceImpl =
        ForgetPasswordRemoteDataSourceImpl(mockApiClient);
  });
  group('ForgetPasswordRemoteDataSourceImpl', () {
    test('Should return Success When ApiClient returns Success', () async {
      //   arrange

      final requestEntity = ForgetPasswordRequestEntity(
          email: 'test@gmail.com');
      final requestDto = ForgetPasswordRequestDto.toDto(requestEntity);
      final responseDto = ForgetPasswordResponseDto(
        message: "email  sent", info: "",);
      when(mockConnectivity.checkConnectivity()).thenAnswer((_)async=>[ConnectivityResult.wifi] );
       when(mockApiClient.forgetPassword(request: requestDto)).thenAnswer((_)
      async => responseDto);

      //   Act
      final res = await forgetPasswordRemoteDataSourceImpl.getForgetPassword(
        requestEntity,
      );
      //   Assert
      verify(mockApiClient.forgetPassword(request: requestDto)).called(1);
      expect(res, isA<Success<ForgetPasswordResponseEntity>>());
      res as  Success<ForgetPasswordResponseEntity>;
      expect(res.data.message, equals(responseDto.message));
    });
  });
}













