import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source_impl.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../add_to_cart/remote_data_source/add_to_cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final AddToCartRemoteDataSourceImpl addToCartRemoteDataSourceImpl;
  late final AddToCartRequestEntity request;

  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    addToCartRemoteDataSourceImpl = AddToCartRemoteDataSourceImpl(
      mockApiClient,
    );
    request = AddToCartRequestEntity(productId: "202556", quantity: 5);
  });
  test(
    'when call addProductToCart it should be called successfully from ApiClient',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.addProductToCart(
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await addToCartRemoteDataSourceImpl.addProductToCart(
        request: request,
      );
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockApiClient.addProductToCart(
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).called(1);
    },
  );
}
