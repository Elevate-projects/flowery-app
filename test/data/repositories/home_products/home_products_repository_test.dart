import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/home_products/home_products_data_source.dart';
import 'package:flowery_app/data/repositories/home_products/home_products_repository_impl_.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_products_repository_test.mocks.dart';
@GenerateMocks([HomeProductsDataSource])
void main() {
  test("when call homeproductsdatasource it should return correct data", ()async{
    //arrange
    final mockDataSource = MockHomeProductsDataSource();
    final repository = HomeProductsRepositoryImpl(mockDataSource);
    ProductsResponseEntity homeProductsEntity = const ProductsResponseEntity(
      message: "Success",
      products: [
        ProductCardEntity(
          productId: "1",
          title: "Rose Bouquet",
          price: 29,
          imgCover: "https://example.com/rose_bouquet.jpg",
          description: "A beautiful bouquet of red roses.",
          category: "Bouquets",
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
    final expectedResult = Success(homeProductsEntity);
    provideDummy<Result<ProductsResponseEntity>>(expectedResult);
    when(mockDataSource.getHomeProducts()).thenAnswer((_) async => expectedResult);
    //act
    final result = await repository.getHomeProducts();
    final actualResult = result as Success<ProductsResponseEntity>;
    //assert
    verify(mockDataSource.getHomeProducts()).called(1);
    expect(actualResult, isA<Success<ProductsResponseEntity?>>());
    expect(actualResult.data.message, expectedResult.data.message);
      expect(actualResult.data.products?.first.productId, expectedResult.data.products?.first.productId);
      expect(actualResult.data.categories?.first.id, expectedResult.data.categories?.first.id);
      expect(actualResult.data.occasions?.first.id, expectedResult.data.occasions?.first.id);
      expect(actualResult.data.bestSeller, expectedResult.data.bestSeller);
      expect(actualResult.data.products?.first.imgCover, expectedResult.data.products?.first.imgCover);
      expect(actualResult.data.categories?.first.image, expectedResult.data.categories?.first.image);
      expect(actualResult.data.occasions?.first.image, expectedResult.data.occasions?.first.image);
  });
}