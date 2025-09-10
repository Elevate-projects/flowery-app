import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/cart/remote_data_source_get_logged_user_imp/remote_data_source_get_logged_user_imp.dart';
import 'package:flowery_app/api/responses/cart_response/cart.dart';
import 'package:flowery_app/api/responses/cart_response/cart_items.dart';
import 'package:flowery_app/api/responses/cart_response/get_logged_user_cart.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../cart/remote_data_source_get_logged_user_imp/remote_data_source_get_logged_user_imp_test.mocks.dart';
@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final RemoteDataSourceGetLoggedUserImp remoteDataSourceGetLoggedUserImp;
  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    remoteDataSourceGetLoggedUserImp =
        RemoteDataSourceGetLoggedUserImp(mockApiClient);
  });
  test('when call remote_data_source_get_logged_user_imp should return success', ()async {
    // Arrange
   final GetLoggedUserCartModel getLoggedUserCart = GetLoggedUserCartModel(
     message: "success",
     numOfCartItems: 1,
     cart: Cart(
       id: "123",
       user: "123",
       cartItems: [
         CartItemsModel(
           id: "123",
           quantity: 1,
           price: 123,
         ),

       ]
     )
   );
    when(mockedConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(mockApiClient.getLoggedUserCart(token: "Bearer ${FloweryMethodHelper.currentUserToken = "fake_token"}",))
        .thenAnswer((_) async => getLoggedUserCart);
    // act
    final result = await remoteDataSourceGetLoggedUserImp.getLoggedUserCart();
    // assert
    expect(result, isA<Success<GetLoggedUserCartEntity>>());
    verify(mockApiClient.getLoggedUserCart(token: "Bearer ${FloweryMethodHelper.currentUserToken = "fake_token"}",)).called(1);
  });
}