import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/logout/remote_data_source/logout_remote_data_source_impl.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../logout/remote_data_source/logout_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final LogoutRemoteDataSourceImpl logoutRemoteDataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    logoutRemoteDataSource = LogoutRemoteDataSourceImpl(mockApiClient);
  });
  test(
    'when call logout it should be called successfully from ApiClient',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.logout(token: anyNamed("token")),
      ).thenAnswer((_) async {});

      // Act
      final result = await logoutRemoteDataSource.logout();
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(mockApiClient.logout(token: anyNamed("token"))).called(1);
    },
  );
}
