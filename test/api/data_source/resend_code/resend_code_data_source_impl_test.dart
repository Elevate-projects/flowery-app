import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/data_source/resend_code/resend_code_data_source_impl.dart';
import 'package:flowery_app/api/responses/resend_code/resend_code_response_dto.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling resendCodeEndpoint from API', () async {
    var mockApiClient = MockApiClient();
    var mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    ResendCodeDataSourceImpl dataSource = ResendCodeDataSourceImpl(
      mockApiClient,
    );

    var resendCodeRequest = ResendCodeRequestEntity(
      email: 'moaazhassan559@gmail.com',
    );

    var expectedResponse = ResendCodeResponseDto(
      message: 'Verification code sent successfully',
      info: 'Please check your email for the verification code.',
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.resendCode(RequestMapper.resendCodeToDto(resendCodeRequest)),
    ).thenAnswer((_) async => expectedResponse);

    var result = await dataSource.resendCode(resendCodeRequest);

    verify(
      mockApiClient.resendCode(RequestMapper.resendCodeToDto(resendCodeRequest)),
    ).called(1);

    expect(result, isA<Success<ResendCodeResponseEntity>>());

    result as Success<ResendCodeResponseEntity>;

    expect(result.data.message, expectedResponse.message);
  });
}
