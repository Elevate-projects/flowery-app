import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/data_source/verification/verification_data_source_impl.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling verificationEndpoint from API', () async {
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final VreificationDataSourceImpl dataSource = VreificationDataSourceImpl(
      mockApiClient,
    );

    final verifyRequest = VerifyRequestEntity(resetCode: '123456');

    final expectedResponse = const VerifyResponseDto(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.verificationCode(RequestMapper.verifyToDto(verifyRequest)),
    ).thenAnswer((_) async => expectedResponse);

    final result = await dataSource.verify(verifyRequest);

    verify(
      mockApiClient.verificationCode(RequestMapper.verifyToDto(verifyRequest)),
    ).called(1);

    expect(result, isA<Success<VerifyResponseEntity>>());

    result as Success<VerifyResponseEntity>;

    expect(result.data.message, expectedResponse.message);
  });
}
