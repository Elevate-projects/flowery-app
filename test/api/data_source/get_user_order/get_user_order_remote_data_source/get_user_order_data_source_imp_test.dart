import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/get_user_order/get_user_order_remote_data_source/get_user_order_data_source_imp.dart';
import 'package:flowery_app/api/models/order_Item_model/get_user_order_model.dart';
import 'package:flowery_app/api/models/orders_items_get_user_order/order_items_get_user_order.dart';
import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/api/responses/get_user_order/get_user_order_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:mockito/mockito.dart';
import 'get_user_order_data_source_imp_test.mocks.dart';
@GenerateMocks([ApiClient, Connectivity])
void main() {
  late MockApiClient mockApiClient;
  late MockConnectivity mockedConnectivity;
  late GetUserOrderDataSourceImp remoteDataSourceGetUserOrderImp;

  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;

    remoteDataSourceGetUserOrderImp =
        GetUserOrderDataSourceImp(mockApiClient);
  });

  test('when call remote_data_source_get_user_order_imp should return success', () async {
    // Arrange
    FloweryMethodHelper.currentUserToken = "fake_token";

    final mockResponse = GetUserOrderResponse(
      message: "success",
      orders: [
        OrderItemModel(
          id: "123",
          user: "123",
          orderItems: [
            OrderItems(
              product: ProductCardModel(
                id: "ss",
                v: 0,
                title: "123",
                imgCover: "123",
              )
            )
          ],
        )
      ],
    );

    when(mockedConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(mockApiClient.getUserOrder(token: "Bearer fake_token"))
        .thenAnswer((_) async => mockResponse);

    // Act
    final result = await remoteDataSourceGetUserOrderImp.getUserOrder();

    // Assert
    expect(result, isA<Success<List<OrderEntity>>>());
    verify(mockApiClient.getUserOrder(token: "Bearer fake_token")).called(1);
    final successResult = result as Success<List<OrderEntity>>;
    expect(successResult.data.first.id, mockResponse.orders?.first.id);
    expect(successResult.data.first.user, mockResponse.orders?.first.user);
  });

}
