import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/responses/get_user_order/get_user_order.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/data_source/get_user_order/get_user_order_remote_data_source/get_user_order_data_source_imp.dart';
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
    final GetUserOrder getUserOrder = GetUserOrder(
      message: "success",
      metadata: Metadata(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 1,
      ),
        orders: [
          Orders(
            id: "123",
            user: "123",
            orderItems: [
              OrderItems(
                product: Product(
                  id: "123",
                  title: "123",
                  slug: "123",
                  description: "123",
                  imgCover: "123",
                  images: ["123"],
                  price: 123,
                  priceAfterDiscount: 123,
                  quantity: 123,
                  category: "123",
                  occasion: "123",
                  createdAt: "123",
                  updatedAt: "123",
                  V: 123,
                  isSuperAdmin: true,
                  sold: 123,
                  rateAvg: 123,
                  rateCount: 123
                )
              )
            ]
          )
        ]
    );
    when(mockedConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(mockApiClient.getUserOrder(token: "Bearer ${FloweryMethodHelper.currentUserToken = "fake_token"}",))
        .thenAnswer((_) async => getUserOrder);
    final result = await remoteDataSourceGetUserOrderImp.getUserOrder();
    expect(result, isA<Success<GetUserOrderEntity>>());
    verify(mockApiClient.getUserOrder(token: "Bearer ${FloweryMethodHelper.currentUserToken = "fake_token"}",)).called(1);

  });
}
