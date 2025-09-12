import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/categories/remote_data_source/categories_remote_data_source.dart';
import 'package:flowery_app/data/repositories/categories/categories_repository_impl.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repository_impl_test.mocks.dart';

@GenerateMocks([CategoriesRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final CategoriesRepositoryImpl categoriesRepositoryImpl;
  late final CategoriesRemoteDataSource categoriesRemoteDataSource;
  setUpAll(() {
    categoriesRemoteDataSource = MockCategoriesRemoteDataSource();
    categoriesRepositoryImpl = CategoriesRepositoryImpl(
      categoriesRemoteDataSource,
    );
  });
  group(" Categories repository implementation test", () {
    test(
      'when call getAllCategories it should be called successfully from CategoriesRemoteDataSource and return List<CategoryEntity>',
      () async {
        // Arrange
        final List<CategoryEntity> expectedListOfCategories = [
          CategoryEntity(
            id: "673c46fd1159920171827c85",
            name: "flowers",
            slug: "flowers",
            image: "flower image",
            productsCount: 15,
          ),
          CategoryEntity(
            id: "673c46fd1159920185",
            name: "crowns",
            slug: "crowns",
            image: "crown image",
            productsCount: 300,
          ),
        ];
        final expectedCategoriesResult = Success(expectedListOfCategories);
        provideDummy<Result<List<CategoryEntity>?>>(expectedCategoriesResult);
        when(
          categoriesRemoteDataSource.getAllCategories(),
        ).thenAnswer((_) async => expectedCategoriesResult);

        // Act
        final result = await categoriesRepositoryImpl.getAllCategories();
        final successResult = result as Success<List<CategoryEntity>?>;

        // Assert
        expect(result, isA<Success<List<CategoryEntity>?>>());
        verify(categoriesRemoteDataSource.getAllCategories()).called(1);
        expect(
          expectedCategoriesResult.data.elementAt(0).id,
          equals(successResult.data?.elementAt(0).id),
        );
        expect(
          expectedCategoriesResult.data.elementAt(0).name,
          equals(successResult.data?.elementAt(0).name),
        );
        expect(
          expectedCategoriesResult.data.elementAt(0).slug,
          equals(successResult.data?.elementAt(0).slug),
        );
        expect(
          expectedCategoriesResult.data.elementAt(0).productsCount,
          equals(successResult.data?.elementAt(0).productsCount),
        );
        expect(
          expectedCategoriesResult.data.elementAt(0).image,
          equals(successResult.data?.elementAt(0).image),
        );
      },
    );

    test(
      'when call getAllProducts it should be called successfully from CategoriesRemoteDataSource and return List<ProductCardEntity>',
      () async {
        // Arrange
        final List<ProductCardEntity> expectedListOfProducts = [
          const ProductCardEntity(
            title: "Red Rose Bouquet",
            slug: "red-rose-bouquet",
            description:
                "A beautiful bouquet of fresh red roses, perfect for romantic occasions.",
            imgCover: "https://example.com/images/red_rose_cover.jpg",
            images: [
              "https://example.com/images/red_rose_1.jpg",
              "https://example.com/images/red_rose_2.jpg",
            ],
            price: 500,
            priceAfterDiscount: 400,
            quantity: 50,

            sold: 20,
            productId: "P001",
          ),
          const ProductCardEntity(
            title: "Luxury Chocolate Box",
            slug: "luxury-chocolate-box",
            description:
                "A premium assortment of luxury chocolates in an elegant gift box.",
            imgCover: "https://example.com/images/choco_cover.jpg",
            images: [
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
        final expectedProductsResult = Success(expectedListOfProducts);
        provideDummy<Result<List<ProductCardEntity>?>>(expectedProductsResult);
        when(
          categoriesRemoteDataSource.getAllProducts(),
        ).thenAnswer((_) async => expectedProductsResult);

        // Act
        final result = await categoriesRepositoryImpl.getAllProducts();
        final successResult = result as Success<List<ProductCardEntity>?>;

        // Assert
        expect(result, isA<Success<List<ProductCardEntity>?>>());
        verify(categoriesRemoteDataSource.getAllProducts()).called(1);
        expect(
          expectedProductsResult.data.elementAt(0).slug,
          equals(successResult.data?.elementAt(0).slug),
        );
        expect(
          expectedProductsResult.data.elementAt(0).occasionId,
          equals(successResult.data?.elementAt(0).occasionId),
        );
        expect(
          expectedProductsResult.data.elementAt(0).categoryId,
          equals(successResult.data?.elementAt(0).categoryId),
        );
        expect(
          expectedProductsResult.data.elementAt(0).images?[0],
          equals(successResult.data?.elementAt(0).images?[0]),
        );
        expect(
          expectedProductsResult.data.elementAt(0).imgCover,
          equals(successResult.data?.elementAt(0).imgCover),
        );
        expect(
          expectedProductsResult.data.elementAt(0).title,
          equals(successResult.data?.elementAt(0).title),
        );
        expect(
          expectedProductsResult.data.elementAt(0).description,
          equals(successResult.data?.elementAt(0).description),
        );
        expect(
          expectedProductsResult.data.elementAt(0).price,
          equals(successResult.data?.elementAt(0).price),
        );
        expect(
          expectedProductsResult.data.elementAt(0).priceAfterDiscount,
          equals(successResult.data?.elementAt(0).priceAfterDiscount),
        );
        expect(
          expectedProductsResult.data.elementAt(0).quantity,
          equals(successResult.data?.elementAt(0).quantity),
        );
        expect(
          expectedProductsResult.data.elementAt(0).productId,
          equals(successResult.data?.elementAt(0).productId),
        );
        expect(
          expectedProductsResult.data.elementAt(0).discountPercentage,
          equals(successResult.data?.elementAt(0).discountPercentage),
        );
      },
    );
  });
}
