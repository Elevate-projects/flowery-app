import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/cart/remote_data_source_delete_item_imp/remote_data_source_delete_item_imp.dart';
import 'package:flowery_app/api/responses/cart_response/delete_items.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../cart/remote_data_source_delete_item_imp/remote_data_source_delete_item_imp_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late MockApiClient mockApiClient;
  late MockConnectivity mockedConnectivity;
  late RemoteDataSourceDeleteItemImp remoteDataSourceDeleteItemImp;

  setUp(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    remoteDataSourceDeleteItemImp =
        RemoteDataSourceDeleteItemImp(apiClient: mockApiClient);
  });
  test('when call remote_data_source_delete_item_imp should return success',
          () async {
        /// arrange
        const productId = "123";
        const _ = "fake_token";

        final deleteItems = DeleteItem(
          message: "success",
          numOfCartItems: 1,
        );

        when(mockedConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);

        when(mockApiClient.deleteCartQuantity(
          productId: productId,
          token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        )).thenAnswer((_) async => deleteItems);

        /// act
        final result =
        await remoteDataSourceDeleteItemImp.deleteCartItem(productId);

        /// assert
        expect(result, isA<Success<DeleteItemsEntity>>());
        verify(mockApiClient.deleteCartQuantity(
          productId: productId,
          token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        )).called(1);
      });
}
