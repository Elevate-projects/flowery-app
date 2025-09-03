import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_categories_use_case.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_products_use_case.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_intent.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_cubit_test.mocks.dart';

@GenerateMocks([GetAllCategoriesUseCase, GetAllProductsUseCase])
void main() {
  late MockGetAllCategoriesUseCase mockGetAllCategoriesUseCase;
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;
  late CategoriesCubit cubit;

  late List<CategoryEntity> fakeCategories;
  late List<ProductCardEntity> fakeProducts;

  late Result<List<CategoryEntity>?> successCategoriesResult;
  late Result<List<ProductCardEntity>?> successProductsResult;
  late Failure<List<CategoryEntity>?> failureCategoriesResult;
  late Failure<List<ProductCardEntity>?> failureProductsResult;

  setUpAll(() {
    mockGetAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();

    fakeCategories = [
      CategoryEntity(
        id: "1",
        name: "Roses",
        slug: "roses",
        productsCount: 5,
        image: "image rose",
      ),
      CategoryEntity(
        id: "2",
        name: "Tulips",
        slug: "Tulips",
        productsCount: 20,
        image: "image Tulips",
      ),
    ];

    fakeProducts = [
      ProductCardEntity(
        title: "Red Rose Bouquet",
        slug: "red-rose-bouquet",
        description:
            "A beautiful bouquet of fresh red roses, perfect for romantic occasions.",
        imgCover: "https://example.com/images/red_rose_cover.jpg",
        images: const [
          "https://example.com/images/red_rose_1.jpg",
          "https://example.com/images/red_rose_2.jpg",
        ],
        price: 500,
        priceAfterDiscount: 400,
        quantity: 50,

        sold: 20,
        productId: "P001",
      ),
      ProductCardEntity(
        title: "Luxury Chocolate Box",
        slug: "luxury-chocolate-box",
        description:
            "A premium assortment of luxury chocolates in an elegant gift box.",
        imgCover: "https://example.com/images/choco_cover.jpg",
        images: const [
          "https://example.com/images/choco_1.jpg",
          "https://example.com/images/choco_2.jpg",
        ],
        price: 800,
        priceAfterDiscount: 720,
        quantity: 100,
        sold: 45,
        productId: "P002",
      ),
    ];

    successCategoriesResult = Success<List<CategoryEntity>?>(fakeCategories);
    successProductsResult = Success<List<ProductCardEntity>?>(fakeProducts);

    failureCategoriesResult = Failure(
      responseException: const ResponseException(
        message: "Failed to load categories",
      ),
    );
    failureProductsResult = Failure(
      responseException: const ResponseException(
        message: "Failed to load products",
      ),
    );

    provideDummy<Result<List<CategoryEntity>?>>(successCategoriesResult);
    provideDummy<Result<List<CategoryEntity>?>>(failureCategoriesResult);
    provideDummy<Result<List<ProductCardEntity>?>>(successProductsResult);
    provideDummy<Result<List<ProductCardEntity>?>>(failureProductsResult);
  });

  setUp(() {
    cubit = CategoriesCubit(
      mockGetAllCategoriesUseCase,
      mockGetAllProductsUseCase,
    );
  });

  group("CategoriesCubit Tests", () {
    blocTest<CategoriesCubit, CategoriesState>(
      'emits loading then success for categories and products on initialization',
      build: () {
        when(
          mockGetAllCategoriesUseCase.invoke(),
        ).thenAnswer((_) async => successCategoriesResult);
        when(
          mockGetAllProductsUseCase.invoke(),
        ).thenAnswer((_) async => successProductsResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: CategoriesInitializationIntent()),
      expect: () => [
        isA<CategoriesState>().having(
          (s) => s.categoriesStatus.isLoading,
          "categoriesStatus loading",
          true,
        ),
        isA<CategoriesState>().having(
          (s) => s.categoriesStatus.isSuccess,
          "categoriesStatus success",
          true,
        ),
        isA<CategoriesState>().having(
          (s) => s.productsStatus.isLoading,
          "productsStatus loading",
          true,
        ),
        isA<CategoriesState>().having(
          (s) => s.productsStatus.isSuccess,
          "productsStatus success",
          true,
        ),
        isA<CategoriesState>()
            .having(
              (s) => s.categoriesProductsList.isNotEmpty,
              "categoriesProductsList populated",
              true,
            )
            .having(
              (s) => s.selectedCategories.contains("all"),
              "selectedCategories contains all",
              true,
            ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits failure for categories when GetAllCategoriesUseCase fails',
      build: () {
        when(
          mockGetAllCategoriesUseCase.invoke(),
        ).thenAnswer((_) async => failureCategoriesResult);
        when(
          mockGetAllProductsUseCase.invoke(),
        ).thenAnswer((_) async => failureProductsResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: CategoriesInitializationIntent()),
      expect: () => [
        isA<CategoriesState>().having(
          (s) => s.categoriesStatus.isLoading,
          "categoriesStatus loading",
          true,
        ),
        isA<CategoriesState>()
            .having(
              (s) => s.categoriesStatus.isFailure,
              "categoriesStatus failure",
              true,
            )
            .having(
              (s) => s.categoriesStatus.error?.message,
              "failure message",
              "Failed to load categories",
            ),

        isA<CategoriesState>().having(
          (s) => s.productsStatus.isLoading,
          "productsStatus loading",
          true,
        ),
        isA<CategoriesState>()
            .having(
              (s) => s.productsStatus.isFailure,
              "productsStatus failure",
              true,
            )
            .having(
              (s) => s.productsStatus.error?.message,
              "failure message",
              "Failed to load products",
            ),
      ],
    );
  });
}
