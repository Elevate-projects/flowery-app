import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/data_source/reset_password/reset_password_data_source_impl.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response_dto.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling resetCodeEndpoint from API', () async {
    var mockApiClient = MockApiClient();
    var mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    ResetPasswordDataSourceImpl dataSource = ResetPasswordDataSourceImpl(
      mockApiClient,
    );

    var resetCodeRequest = ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: '12345678',
    );

    var expectedResponse = ResetPasswordResponseDto(
      token: 'sample_token',
      message: 'Password reset successfully',
      code: 200,
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.resetPassword(RequestMapper.resetPasswordToDto(resetCodeRequest)),
    ).thenAnswer((_) async => expectedResponse);

    var result = await dataSource.resetPassword(resetCodeRequest);

    verify(
      mockApiClient.resetPassword(RequestMapper.resetPasswordToDto(resetCodeRequest)),
    ).called(1);

    expect(result, isA<Success<ResetPasswordResponseEntity>>());

    result as Success<ResetPasswordResponseEntity>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
