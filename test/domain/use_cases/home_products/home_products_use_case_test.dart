import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/home_products/home_products_repository.dart';
import 'package:flowery_app/domain/use_cases/home_products/home_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_products_use_case_test.mocks.dart';
@GenerateMocks([HomeProductsRepository])
void main(){
test("when call homerepository.gethomedata it should return coorects values", ()async {
  //arrange
  final mockRepository = MockHomeProductsRepository();
  final useCase = HomeProductsUseCase(mockRepository);
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
    when(mockRepository.getHomeProducts()).thenAnswer((_) async => expectedResult);
    //act
    final result = await useCase.invoke();
    final actualResult = result as Success<ProductsResponseEntity>;
    //assert
    verify(mockRepository.getHomeProducts()).called(1);
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