import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';
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
            product: ProductEntity(
              id: "673c46fd1159920171827c85",
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

    // هنا بقى عندك fakeCart جاهز
    provideDummy<Result<GetLoggedUserCartEntity>>(
      Success(fakeCart),
    );
  });

  setUp(() {
    mockGetLoggedUserCartUseCase = MockGetLoggedUserCartUseCase();
    cubit = CartCubit(mockGetLoggedUserCartUseCase);
  });

  group("CartCubit Tests", () {
    blocTest<CartCubit, CartState>(
      'emits failure when token is null',
      build: () => cubit,
      act: (cubit) async =>
      await cubit.doIntent(LoadCartIntent("")),
      expect: () => [
        isA<CartState>()
            .having((s) => s.cartStatus.isFailure, "isFailure", true)
            .having((s) => s.cartStatus.error?.message,
            "error message", "You are not logged in"),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits loading then success when GetLoggedUserCartUseCase returns Success',
      build: () {
        when(mockGetLoggedUserCartUseCase("validToken"))
            .thenAnswer((_) async => Success(fakeCart));
        return cubit;
      },
      act: (cubit) async =>
      await cubit.doIntent(LoadCartIntent("validToken")),
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
        when(mockGetLoggedUserCartUseCase("validToken")).thenAnswer(
              (_) async => Failure(
            responseException:
            const ResponseException(message: "Failed to load cart"),
          ),
        );
        return cubit;
      },
      act: (cubit) async =>
      await cubit.doIntent(LoadCartIntent("validToken")),
      expect: () => [
        isA<CartState>().having((s) => s.cartStatus.isLoading, "isLoading", true),
        isA<CartState>()
            .having((s) => s.cartStatus.isFailure, "isFailure", true)
            .having((s) => s.cartStatus.error?.message,
            "error message", "Failed to load cart"),
      ],
    );
  });
}

