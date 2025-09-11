import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([GetLoggedUserCartUseCase])
void main() {
  late MockGetLoggedUserCartUseCase mockGetLoggedUserCartUseCase;
  late CartCubit cubit;
  late GetLoggedUserCartEntity fakeCart;

  setUpAll(() {
    fakeCart = const GetLoggedUserCartEntity(
      message: "ok",
      numOfCartItems: 1,
      cart: CartEntity(
        id: "673c46fd1159920171827c85",
        user: "673c46fd1159920171827c85",
        cartItems: [
          CartItemEntity(
            id: "673c46fd1159920171827c85",
            price: 0,
            quantity: 0,
            product: ProductCardEntity(
              productId: "673c46fd1159920171827c85",
              title: "flower",
              slug: "flower",
              description: "flower description",
              imgCover: "flower image",
              images: ["flower image"],
            ),
          )
        ],
      ),
    );

    provideDummy<Result<GetLoggedUserCartEntity>>(
      Success(fakeCart),
    );
  });

  setUp(() {
    FloweryMethodHelper.currentUserToken = "fake_token";
    mockGetLoggedUserCartUseCase = MockGetLoggedUserCartUseCase();
    cubit = CartCubit(mockGetLoggedUserCartUseCase);
  });
  blocTest<CartCubit, CartState>(
    'emits failure when token is null',
    build: () {
      FloweryMethodHelper.currentUserToken = null;
      return cubit;
    },
    act: (cubit) async => await cubit.doIntent(LoadCartIntent()),
    expect: () => [
      isA<CartState>()
          .having((s) => s.cartStatus.isFailure, "isFailure", true)
          .having((s) => s.cartStatus.error?.message, "error message", AppText.noToken.tr()),
    ],
  );

  blocTest<CartCubit, CartState>(
    'emits loading then success when GetLoggedUserCartUseCase returns Success',
    build: () {
      when(mockGetLoggedUserCartUseCase())
          .thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 1));
        return Success(fakeCart);
      });
      return cubit;
    },
    act: (cubit) async => await cubit.doIntent(LoadCartIntent()),
    expect: () => [
      isA<CartState>().having((s) => s.cartStatus.isLoading, "isLoading", true),
      isA<CartState>()
          .having((s) => s.cartStatus.isSuccess, "isSuccess", true)
          .having((s) => s.cartStatus.data, "cart data", fakeCart),
    ],
  );

  blocTest<CartCubit, CartState>(
    'emits loading then failure when GetLoggedUserCartUseCase returns Failure',
    build: () {
      when(mockGetLoggedUserCartUseCase()).thenAnswer(
            (_) async {
          await Future.delayed(const Duration(milliseconds: 1));
          return Failure(
            responseException: const ResponseException(message: "Failed to load cart"),
          );
        },
      );
      return cubit;
    },
    act: (cubit) async => await cubit.doIntent(LoadCartIntent()),
    expect: () => [
      isA<CartState>().having((s) => s.cartStatus.isLoading, "isLoading", true),
      isA<CartState>()
          .having((s) => s.cartStatus.isFailure, "isFailure", true)
          .having((s) => s.cartStatus.error?.message, "error message", "Failed to load cart"),
    ],
  );

}
