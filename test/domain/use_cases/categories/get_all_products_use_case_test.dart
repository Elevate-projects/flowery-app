import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/categories/categories_repository.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_products_use_case_test.mocks.dart';

@GenerateMocks([CategoriesRepository])
void main() {
  test(
    'when call getAllProducts it should be called successfully from CategoriesRemoteDataSource and return List<ProductCardEntity>',
    () async {
      // Arrange
      final mockedCategoriesRepository = MockCategoriesRepository();
      final getAllProductsUseCase = GetAllProductsUseCase(
        mockedCategoriesRepository,
      );
      final List<ProductCardEntity> expectedListOfProducts = [
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
      final expectedProductsResult = Success(expectedListOfProducts);
      provideDummy<Result<List<ProductCardEntity>?>>(expectedProductsResult);
      when(
        mockedCategoriesRepository.getAllProducts(),
      ).thenAnswer((_) async => expectedProductsResult);

      // Act
      final result = await getAllProductsUseCase.invoke();
      final successResult = result as Success<List<ProductCardEntity>?>;

      // Assert
      expect(result, isA<Success<List<ProductCardEntity>?>>());
      verify(mockedCategoriesRepository.getAllProducts()).called(1);
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
}
