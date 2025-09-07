import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/repositories/cart/cart_repositories/cart_repositories.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_use_case_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {
  test(
    'when call GetLoggedUserCartUseCase it should be called successfully should return GetLoggedUserCartEntity',
    () async {
      final mockedCartRepository = MockCartRepository();
      final getLoggedUserCartUseCase = GetLoggedUserCartUseCase(
        mockedCartRepository,
      );
      final expectedGetLoggedUserCartEntity = GetLoggedUserCartEntity(
        message: "ok",
        numOfCartItems: 1,
        cart: CartEntity(
          id: "673c46fd1159920171827c85",
          user: "673c46fd1159920171827c85",
          cartItems: [
            CartItemEntity(
              product: ProductEntity(
                id: "673c46fd1159920171827c85",
                title: "flower",
                slug: "flower",
                description: "flower description",
                imgCover: "flower image",
                images: ["flower image"],
              ),
              price: 100,
              quantity: 1,
              id: "673c46fd1159920171827c85",
            ),
          ],
          appliedCoupons: [],
          totalPrice: 100,
          v: 0,
          createdAt: "saa",
          updatedAt: "saa",
        ),
      );
    final expectedGetLoggedUserCartResult = Success(expectedGetLoggedUserCartEntity);
    provideDummy<Result<GetLoggedUserCartEntity>>(expectedGetLoggedUserCartResult);
    when(
      mockedCartRepository.getLoggedUserCart("token"),
    ).thenAnswer((_) async => expectedGetLoggedUserCartResult);
    final result = await getLoggedUserCartUseCase.call("token");
    final successResult = result as Success<GetLoggedUserCartEntity>;
    expect(result, isA<Success<GetLoggedUserCartEntity>>());
    verify(mockedCartRepository.getLoggedUserCart("token")).called(1);
    expect(
      expectedGetLoggedUserCartResult.data.message,
      equals(successResult.data.message),
    );
    },
  );
}
