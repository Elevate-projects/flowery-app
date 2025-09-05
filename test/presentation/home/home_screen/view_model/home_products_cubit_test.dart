import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/home_products/home_products_use_case.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_products_cubit_test.mocks.dart';

@GenerateMocks([HomeProductsUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeProductsUseCase mockHomeProductsUseCase;
  late HomeProductsCubit homeProductsCubit;
  late Result<ProductsResponseEntity> expectedSuccessResult;
  late Failure<ProductsResponseEntity> expectedFailureResult;
  late ProductsResponseEntity productsResponseEntity;
  setUpAll(() {
    mockHomeProductsUseCase = MockHomeProductsUseCase();
    expectedFailureResult = Failure(
      responseException: const ResponseException(message: 'Error occurred'),
    );
    productsResponseEntity = const ProductsResponseEntity(
      message: "Success",
      products: [
        ProductCardEntity(
          productId: "1",
          title: "Rose Bouquet",
          price: 29,
          imgCover: "https://example.com/rose_bouquet.jpg",
          description: "A beautiful bouquet of red roses.",
          categoryId: "Bouquets",
        ),
      ],
      categories: [
        CategoryEntity(
          id: '1',
          name: "Bouquets",
          image: "https://example.com/bouquets_category.jpg",
          createdAt: '2023-01-01T00:00:00Z',
        ),
      ],
      occasions: [
        OccasionEntity(
          id: '1',
          name: "Wedding",
          image: "https://example.com/wedding_occasion.jpg",
          createdAt: '2023-01-01T00:00:00Z',
        ),
      ],
    );
    expectedSuccessResult = Success<ProductsResponseEntity>(
      productsResponseEntity,
    );
    provideDummy<Result<ProductsResponseEntity>>(expectedSuccessResult);
    provideDummy<Result<ProductsResponseEntity>>(expectedFailureResult);
  });
  setUp(() {
    homeProductsCubit = HomeProductsCubit(mockHomeProductsUseCase);
  });
  group("home products cubit test", () {
    blocTest<HomeProductsCubit, HomeProductsState>(
      "emits [loading,success] when data returned successfully",
      build: () {
        when(
          mockHomeProductsUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return homeProductsCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: GetAllProductsIntent())],
      expect: () => [
        isA<HomeProductsState>().having(
          (state) => state.homeState.isLoading,
          "loading",
          equals(true),
        ),
        isA<HomeProductsState>()
            .having(
              (state) => state.homeState.isSuccess,
              "success",
              equals(true),
            )
            .having(
              (state) => state.homeState.data,
              "check if data returned successfully and equals expected data",
              equals((expectedSuccessResult as Success<ProductsResponseEntity>).data),
            ),
      ],
      verify: (cubit) => verify(mockHomeProductsUseCase.invoke()).called(1),
    );

    blocTest<HomeProductsCubit, HomeProductsState>(
      "emits [loading,failure] when data fails",
      build: () {
        when(
          mockHomeProductsUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return homeProductsCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: GetAllProductsIntent())],
      expect: () => [
        isA<HomeProductsState>().having(
          (state) => state.homeState.isLoading,
          "loading",
          equals(true),
        ),
        isA<HomeProductsState>()
            .having(
              (state) => state.homeState.isFailure,
              "failure",
              equals(true),
            )
            .having(
              (state) => state.homeState.error?.message,
              "response exception message",
              equals(expectedFailureResult.responseException.message),
            ),
      ],
      verify: (cubit) => verify(mockHomeProductsUseCase.invoke()).called(1),
    );
  });
}
