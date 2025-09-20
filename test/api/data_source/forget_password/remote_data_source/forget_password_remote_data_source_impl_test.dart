import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/forget_password/remote_data_source/forget_password_remote_data_source_impl.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../add_to_cart/remote_data_source/add_to_cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  final mockConnectivity = MockConnectivity();
  ConnectionManager.connectivity = mockConnectivity;
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiClient mockApiClient;
  late ForgetPasswordRemoteDataSourceImpl forgetPasswordRemoteDataSourceImpl;
  setUpAll(() {
    mockApiClient = MockApiClient();
    forgetPasswordRemoteDataSourceImpl = ForgetPasswordRemoteDataSourceImpl(
      mockApiClient,
    );
  });
  group(
    'test forgetPassword function in ForgetPasswordRemoteDataSourceImpl',
    () {
      test(
        'should return Success<ForgetPasswordEntity> when API call succeeds',
        () async {
          final ForgetPasswordRequestEntity requestEntity =
              const ForgetPasswordRequestEntity(email: "peter@gmail.com");
          final mockForgetPasswordResponseModel = ForgetPasswordResponseModel(
            message: 'message test',
            info: 'info test',
          );
          when(
            mockConnectivity.checkConnectivity(),
          ).thenAnswer((_) async => [ConnectivityResult.wifi]);
          when(
            mockApiClient.forgetPassword(request: anyNamed("request")),
          ).thenAnswer((_) async => mockForgetPasswordResponseModel);
          final result = await forgetPasswordRemoteDataSourceImpl
              .forgetPassword(requestEntity);

          expect(result, isA<Success<ForgetPasswordEntity>>());
          verify(
            mockApiClient.forgetPassword(request: anyNamed("request")),
          ).called(1);
        },
      );
    },
  );
}
