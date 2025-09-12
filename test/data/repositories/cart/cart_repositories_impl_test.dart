import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_get_logged_user/remote_data_source_get_logged_user.dart';
import 'package:flowery_app/data/repositories/cart/cart_repo_imp/cart_repositories_impl.dart';
import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'cart_repositories_impl_test.mocks.dart';
@GenerateMocks([RemoteDataSourceGetLoggedUser])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final CartRepositoryImpl cartRepositoryImpl;
 late final RemoteDataSourceGetLoggedUser remoteDataSourceGetLoggedUser;
  setUpAll(() {

    remoteDataSourceGetLoggedUser = MockRemoteDataSourceGetLoggedUser();
    cartRepositoryImpl = CartRepositoryImpl(remoteDataSourceGetLoggedUser);
  });
  test('when call getLoggedUserCart it should be called successfully from RemoteDataSourceGetLoggedUser and return GetLoggedUserCartEntity', ()async {
    final expectedCart = const GetLoggedUserCartEntity(
      message: "success",
      numOfCartItems: 10,
      cart: CartEntity(
        id: "673c46fd1159920171827c85",
        user: "673c46fd1159920185",
        cartItems: [
          CartItemEntity(
            product: ProductCardEntity(
              productId: "673c46fd1159920185",
              title : "Red Rose Bouquet",
              slug: "red-rose-bouquet",
              description: "A beautiful bouquet of fresh red roses, perfect for romantic occasions.",
              imgCover: "https://example.com/images/red_rose_cover.jpg",
              images: [
                "https://example.com/images/red_rose_1.jpg",
                "https://example.com/images/red_rose_2.jpg",
              ],
              price: 0,
              categoryId: "000000000000",
              discountPercentage: "od",
          ))
        ],
      ),
    );
    final expectedCartResult = Success(expectedCart);
    provideDummy<Result<GetLoggedUserCartEntity>>(expectedCartResult);
    when(
      remoteDataSourceGetLoggedUser.getLoggedUserCart(),
    ).thenAnswer((_) async => expectedCartResult);
    final result = await cartRepositoryImpl.getLoggedUserCart();
    expect(result, isA<Success<GetLoggedUserCartEntity>>());
    expect(result, expectedCartResult);
    verify(remoteDataSourceGetLoggedUser.getLoggedUserCart()).called(1);
  });
}