import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/use_cases/add_to_cart/add_product_to_cart_use_case.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_intent.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_product_to_cart_cubit_test.mocks.dart';

@GenerateMocks([AddProductToCartUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAddProductToCartUseCase mockAddProductToCartUseCase;
  late final AddToCartRequestEntity request;
  late Result<void> expectedSuccessResult;
  late Failure<void> expectedFailureResult;
  late AddProductToCartCubit cubit;

  setUpAll(() {
    mockAddProductToCartUseCase = MockAddProductToCartUseCase();

    request = AddToCartRequestEntity(productId: "202556", quantity: 5);
  });

  setUp(() {
    cubit = AddProductToCartCubit(mockAddProductToCartUseCase);
  });

  group("Add Product To Cart Cubit test", () {
    blocTest<AddProductToCartCubit, AddProductToCartState>(
      "emits [Loading, Success] when AddToCartIntent is Called",
      build: () {
        expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockAddProductToCartUseCase.invoke(request: request),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: AddToCartIntent(request: request)),
      expect: () => [
        isA<AddProductToCartState>().having(
          (state) => state.addToCartStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<AddProductToCartState>().having(
          (state) => state.addToCartStatus.isSuccess,
          "Is Success State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(mockAddProductToCartUseCase.invoke(request: request)).called(1);
      },
    );

    blocTest<AddProductToCartCubit, AddProductToCartState>(
      "emits [Loading, Failure] when AddToCartIntent is Called",
      build: () {
        expectedFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "Failed adding product to cart",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockAddProductToCartUseCase.invoke(request: request),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: AddToCartIntent(request: request)),
      expect: () => [
        isA<AddProductToCartState>().having(
          (state) => state.addToCartStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<AddProductToCartState>()
            .having(
              (state) => state.addToCartStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.addToCartStatus.error?.message,
              "Is having the Failure Message",
              equals("Failed adding product to cart"),
            ),
      ],
      verify: (_) {
        verify(mockAddProductToCartUseCase.invoke(request: request)).called(1);
      },
    );

    blocTest<AddProductToCartCubit, AddProductToCartState>(
      "emits new product id when ChangeSelectedProductId is Called",
      build: () {
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: ChangeSelectedProductId(productId: '200'),
      ),
      expect: () => [
        isA<AddProductToCartState>().having(
          (state) => state.currentProductId,
          "Is currentProductId changed",
          equals("200"),
        ),
      ],
    );
  });
}
