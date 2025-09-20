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
      const ProductCardEntity(
        productId: "p101",
        title: "Flower Basket",
        slug: "flower-basket",
        description: "A lovely basket filled with fresh flowers.",
        imgCover: "https://picsum.photos/id/200/400/300",
        images: [
          "https://picsum.photos/id/200/400/300",
          "https://picsum.photos/id/201/400/300",
        ],
        price: 250,
        priceAfterDiscount: 220,
        quantity: 12,
        categoryId: "1",
        occasionId: "occ_mothersday",
        sold: 40,
        discountPercentage: "12%",
        createdAt: "2024-11-25T23:34:04.896Z",
      ),
      const ProductCardEntity(
        productId: "p102",
        title: "Gift Hamper",
        slug: "gift-hamper",
        description: "A mix of chocolates, cookies, and snacks.",
        imgCover: "https://picsum.photos/id/202/400/300",
        images: [
          "https://picsum.photos/id/202/400/300",
          "https://picsum.photos/id/203/400/300",
        ],
        price: 500,
        priceAfterDiscount: 450,
        quantity: 8,
        categoryId: "1",
        occasionId: "occ_christmas",
        sold: 22,
        discountPercentage: "10%",
        createdAt: "2024-12-10T15:12:30.452Z",
      ),
      const ProductCardEntity(
        productId: "p103",
        title: "Cupcake Box",
        slug: "cupcake-box",
        description: "A box of 6 freshly baked cupcakes.",
        imgCover: "https://picsum.photos/id/204/400/300",
        images: ["https://picsum.photos/id/204/400/300"],
        price: 150,
        priceAfterDiscount: 150,
        quantity: 20,
        categoryId: "1",
        occasionId: "occ_birthday",
        sold: 55,
        discountPercentage: "0%",
        createdAt: "2025-01-05T10:45:55.123Z",
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
    group("ChangeCategoryFilterIntent Tests", () {
      setUp(() {
        when(
          mockGetAllCategoriesUseCase.invoke(),
        ).thenAnswer((_) async => successCategoriesResult);
        when(
          mockGetAllProductsUseCase.invoke(),
        ).thenAnswer((_) async => successProductsResult);
      });

      blocTest<CategoriesCubit, CategoriesState>(
        'changes filter to Lowest Price and sorts products ascending',
        build: () => cubit,
        act: (cubit) async {
          await cubit.doIntent(intent: CategoriesInitializationIntent());
          await cubit.doIntent(
            intent: ChangeCategoryFilterIntent(
              selectedFilter: cubit.filters[0], // lowest price
            ),
          );
        },
        expect: () => [
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>()
              .having(
                (s) => s.selectedFilter,
                "selectedFilter",
                cubit.filters[0],
              )
              .having(
                (s) =>
                    s.categoriesProductsList.first.first.priceAfterDiscount! <=
                    s.categoriesProductsList.first.last.priceAfterDiscount!,
                "sorted ascending by priceAfterDiscount",
                true,
              ),
        ],
      );

      blocTest<CategoriesCubit, CategoriesState>(
        'changes filter to Highest Price and sorts products descending',
        build: () => cubit,
        act: (cubit) async {
          await cubit.doIntent(intent: CategoriesInitializationIntent());
        },
        expect: () => [
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>()
              .having(
                (s) => s.selectedFilter,
                "selectedFilter",
                cubit.filters[1],
              )
              .having(
                (s) =>
                    s.categoriesProductsList.isNotEmpty &&
                    s.categoriesProductsList.first.first.priceAfterDiscount! >=
                        s.categoriesProductsList.first.last.priceAfterDiscount!,
                "sorted descending by priceAfterDiscount",
                true,
              ),
        ],
      );

      blocTest<CategoriesCubit, CategoriesState>(
        'changes filter to Newest and sorts products by createdAt descending',
        build: () => cubit,
        act: (cubit) async {
          await cubit.doIntent(intent: CategoriesInitializationIntent());
          await cubit.doIntent(
            intent: ChangeCategoryFilterIntent(
              selectedFilter: cubit.filters[2], // newest
            ),
          );
        },
        expect: () => [
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>()
              .having(
                (s) => s.selectedFilter,
                "selectedFilter",
                cubit.filters[2],
              )
              .having(
                (s) =>
                    DateTime.parse(
                      s.categoriesProductsList.first.first.createdAt!,
                    ).isAfter(
                      DateTime.parse(
                        s.categoriesProductsList.first.last.createdAt!,
                      ),
                    ),
                "sorted by newest first",
                true,
              ),
        ],
      );

      blocTest<CategoriesCubit, CategoriesState>(
        'changes filter to Oldest and sorts products by createdAt ascending',
        build: () => cubit,
        act: (cubit) async {
          await cubit.doIntent(intent: CategoriesInitializationIntent());
          await cubit.doIntent(
            intent: ChangeCategoryFilterIntent(
              selectedFilter: cubit.filters[3], // oldest
            ),
          );
        },
        expect: () => [
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>()
              .having(
                (s) => s.selectedFilter,
                "selectedFilter",
                cubit.filters[3],
              )
              .having(
                (s) =>
                    DateTime.parse(
                      s.categoriesProductsList.first.first.createdAt!,
                    ).isBefore(
                      DateTime.parse(
                        s.categoriesProductsList.first.last.createdAt!,
                      ),
                    ),
                "sorted by oldest first",
                true,
              ),
        ],
      );

      blocTest<CategoriesCubit, CategoriesState>(
        'changes filter to Discount and sorts products by discountPercentage descending',
        build: () => cubit,
        act: (cubit) async {
          await cubit.doIntent(intent: CategoriesInitializationIntent());
          await cubit.doIntent(
            intent: ChangeCategoryFilterIntent(
              selectedFilter: cubit.filters[4], // discount
            ),
          );
        },
        expect: () => [
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>(),
          isA<CategoriesState>()
              .having(
                (s) => s.selectedFilter,
                "selectedFilter",
                cubit.filters[4],
              )
              .having(
                (s) =>
                    int.parse(
                      s.categoriesProductsList.first.first.discountPercentage!
                          .replaceAll("%", ""),
                    ) >=
                    int.parse(
                      s.categoriesProductsList.first.last.discountPercentage!
                          .replaceAll("%", ""),
                    ),
                "sorted by highest discount first",
                true,
              ),
        ],
      );
    });
  });
}
