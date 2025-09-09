import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/address/remote_data_source/address_remote_data_source_impl.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final AddressRemoteDataSourceImpl addressRemoteDataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    addressRemoteDataSource = AddressRemoteDataSourceImpl(mockApiClient);
  });

  test(
    'when call removeAddress it should be called successfully from ApiClient',
    () async {
      // Arrange
      const testAddressId = "addr_123";
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(
        mockApiClient.removeAddress(
          token: anyNamed("token"),
          addressId: anyNamed("addressId"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await addressRemoteDataSource.removeAddress(
        addressId: testAddressId,
      );
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockApiClient.removeAddress(
          token: anyNamed("token"),
          addressId: testAddressId,
        ),
      ).called(1);
    },
  );
}
