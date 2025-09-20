import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/data_source/address/remote_data_source/address_remote_data_source_impl.dart';
import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:flowery_app/api/responses/add_address_response/add_address_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
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
  test(
    'when call addAddress it should be called successfully from ApiClient',
    () async {
      // Arrange
      final addAddressRequest = AddAddressRequestEntity(
        city: 'Cairo',
        street: '123 Main St',
        username: 'John Doe',
        phone: '1234567890',
        lat: '30.0444',
        long: '31.2357',
      );

      final expectedResponse = AddAddressResponse(
        message: 'Address added successfully',
        address: [
          AddressModel(
            username: 'John Doe',
            phone: '1234567890',
            city: 'Cairo',
            street: '123 Main St',
            lat: '30.0444',
            long: '31.2357',
            id: 'addr_123',
          ),
        ],
      );

      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(
        mockApiClient.addAddress(
          request: RequestMapper.addAddressRequestToModel(addAddressRequest),
          token: anyNamed("token"),
        ),
      ).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await addressRemoteDataSource.addAddress(
        addAddressRequest,
      );

      // Assert
      verify(
        mockApiClient.addAddress(
          request: RequestMapper.addAddressRequestToModel(addAddressRequest),
          token: anyNamed("token"),
        ),
      ).called(1);

      expect(result, isA<Success<List<AddressEntity>?>>());

      final successResult = result as Success<List<AddressEntity>?>;
      expect(successResult.data, isNotNull);
      expect(successResult.data?.length, expectedResponse.address?.length);
      expect(
        successResult.data?.map((e) => e.username),
        expectedResponse.address?.map((e) => e.username),
      );
    },
  );
}
