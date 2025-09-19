import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flowery_app/domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart';
import 'package:flowery_app/domain/use_cases/cart/quantity_use_case/quantity_use_case.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_intent.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  GetLoggedUserCartUseCase,
  QuantityUseCase,
  DeleteCartItemUseCase,
])
void main() {
  late MockGetLoggedUserCartUseCase mockGetLoggedUserCartUseCase;
  late MockQuantityUseCase mockQuantityUseCase;
  late MockDeleteCartItemUseCase mockDeleteCartItemUseCase;
  late CartCubit cartcubit;
  late GetLoggedUserCartEntity fakeCart;

  setUpAll(() {
    mockGetLoggedUserCartUseCase = MockGetLoggedUserCartUseCase();
    mockQuantityUseCase = MockQuantityUseCase();
    mockDeleteCartItemUseCase = MockDeleteCartItemUseCase();
    provideDummy<Result<GetLoggedUserCartEntity>>(
      Failure(responseException: const ResponseException(message: "dummy")),
    );
    provideDummy<Result<GetLoggedUserCartEntity?>>(
      Failure(responseException: const ResponseException(message: "dummy")),
    );
    provideDummy<Result<QuantityEntity>>(
      Failure(responseException: const ResponseException(message: "dummy")),
    );
    provideDummy<Result<DeleteItemsEntity>>(
      Failure(responseException: const ResponseException(message: "dummy")),
    );
  });
  setUp(() {
    cartcubit = CartCubit(
      mockGetLoggedUserCartUseCase,
      mockQuantityUseCase,
      mockDeleteCartItemUseCase,
    );

    fakeCart = const GetLoggedUserCartEntity(
      message: "fake cart",
      numOfCartItems: 1,
      cart: null,
    );
  });
  group("CartCubit Tests", () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] when GetLoggedUserCartUseCase returns Success',
      build: () {
        when(
          mockGetLoggedUserCartUseCase(),
        ).thenAnswer((_) async => Success(fakeCart));
        return cartcubit;
      },
      act: (cubit) => cubit.doIntent(LoadCartIntent()),
      expect: () => [
        isA<CartState>().having(
          (s) => s.cartStatus.isLoading,
          "cartStatus loading",
          true,
        ),
        isA<CartState>().having(
          (s) => s.cartStatus.isSuccess,
          "cartStatus success",
          true,
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, failure] when GetLoggedUserCartUseCase returns Failure',
      build: () {
        when(mockGetLoggedUserCartUseCase()).thenAnswer(
          (_) async => Failure(
            responseException: const ResponseException(
              message: "Failed to load cart",
            ),
          ),
        );
        return cartcubit;
      },
      act: (cubit) => cubit.doIntent(LoadCartIntent()),
      expect: () => [
        isA<CartState>().having(
          (s) => s.cartStatus.isLoading,
          "cartStatus loading",
          true,
        ),
        isA<CartState>().having(
          (s) => s.cartStatus.isFailure,
          "cartStatus failure",
          true,
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, failure] when updateCartQuantity returns Failure',
      build: () {
        when(mockQuantityUseCase.updateCartQuantity("1", 1)).thenAnswer(
          (_) async => Failure(
            responseException: const ResponseException(
              message: "Failed to update quantity",
            ),
          ),
        );
        return cartcubit;
      },
      act: (cubit) => cubit.doIntent(LoadCartIntent()),
      expect: () => [
        isA<CartState>().having(
          (s) => s.cartStatus.isLoading,
          "cartStatus loading",
          true,
        ),
        isA<CartState>().having(
          (s) => s.cartStatus.isFailure,
          "cartStatus failure",
          true,
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, failure] when deleteCartItem returns Failure',
      build: () {
        when(mockDeleteCartItemUseCase.deleteCartItem("1")).thenAnswer(
          (_) async => Failure(
            responseException: const ResponseException(
              message: "Failed to Delete Item",
            ),
          ),
        );
        return cartcubit;
      },
      act: (cubit) => cubit.doIntent(DeleteCartItemIntent(productId: '1')),
      expect: () => [
        isA<CartState>().having(
          (s) => s.deleteStatus.isLoading,
          "deleteItemStatus loading",
          true,
        ),
        isA<CartState>().having(
          (s) => s.deleteStatus.isFailure,
          "deleteItemStatus failure",
          true,
        ),
      ],
    );
  });
}
