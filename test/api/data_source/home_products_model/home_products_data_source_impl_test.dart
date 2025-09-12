
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/home_products/home_products_data_source_impl.dart';
import 'package:flowery_app/api/models/home_products_model/category_model.dart';
import 'package:flowery_app/api/models/home_products_model/occasion_model.dart';
import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/api/responses/home_products/products_response_model.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_products_data_source_impl_test.mocks.dart';
@GenerateMocks([ApiClient, Connectivity])
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 test("when call gethomedata from api client it should return data", () async{
   //arrange
   final mockApiClient = MockApiClient();
   final mockConnectivity = MockConnectivity();
   ConnectionManager.connectivity = mockConnectivity;
   final dataSource = HomeProductsDataSourceImpl(mockApiClient);
   final expectedHomeData =  ProductsResponseModel(
      message: "Success",
      products: [
        ProductCardModel(
          id: "1",
          title: "Rose Bouquet",
          price: 29,
          imgCover: "https://example.com/rose_bouquet.jpg",
          description: "A beautiful bouquet of red roses.",
          category: "Bouquets",
        ),
      ],
      categories: [
        const CategoryModel(
          id: '1',
          name: "Bouquets",
          image: "https://example.com/bouquets_category.jpg",
          createdAt: '2023-01-01T00:00:00Z',
        ),
      ],
      occasions: [
        const OccasionModel(
          id: '1',
          name: "Wedding",
          image: "https://example.com/wedding_occasion.jpg",
          createdAt: '2023-01-01T00:00:00Z', 
        ),
      ],
    );

    final expectedHomeProductsEntinty = Success(
      expectedHomeData.toEntity()
    );
    provideDummy<Result<ProductsResponseEntity>>(expectedHomeProductsEntinty);
    when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.getHomeData(token: anyNamed('token'))
      ).thenAnswer((_) async => expectedHomeData);
      //act 
      final result = await dataSource.getHomeProducts();
      final successResult = result as Success<ProductsResponseEntity>;
      //assert
      expect(result, isA<Success<ProductsResponseEntity?>>());
      verify(mockApiClient.getHomeData(token:anyNamed('token'))).called(1);
      expect(expectedHomeProductsEntinty.data.message, successResult.data.message);
      expect(expectedHomeProductsEntinty.data.products?.first.productId, successResult.data.products?.first.productId);
      expect(expectedHomeProductsEntinty.data.categories?.first.id, successResult.data.categories?.first.id);
      expect(expectedHomeProductsEntinty.data.occasions?.first.id, successResult.data.occasions?.first.id);
      expect(expectedHomeProductsEntinty.data.bestSeller, successResult.data.bestSeller);
      expect(expectedHomeProductsEntinty.data.products?.first.imgCover, successResult.data.products?.first.imgCover);
      expect(expectedHomeProductsEntinty.data.categories?.first.image, successResult.data.categories?.first.image);
      expect(expectedHomeProductsEntinty.data.occasions?.first.image, successResult.data.occasions?.first.image);

  });
}