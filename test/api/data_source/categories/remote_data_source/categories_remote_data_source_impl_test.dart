import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/categories/remote_data_source/categories_remote_data_source_impl.dart';
import 'package:flowery_app/api/models/category/category_model.dart';
import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/api/responses/categories_response/categories_response.dart';
import 'package:flowery_app/api/responses/products_response/products_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final MockConnectivity mockedConnectivity;
  late final CategoriesRemoteDataSourceImpl categoriesRemoteDataSource;
  setUpAll(() {
    mockApiClient = MockApiClient();
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    categoriesRemoteDataSource = CategoriesRemoteDataSourceImpl(mockApiClient);
  });
  group("categories remote data source impl test", () {
    test(
      'when call fetchAllCategories it should be called successfully from apiClient and return List<CategoryEntity>',
      () async {
        // Arrange

        final List<CategoryModel> expectedListOfCategories = [
          CategoryModel(
            id: "673c46fd1159920171827c85",
            name: "flowers",
            slug: "flowers",
            image: "flower image",
            createdAt: "2026",
            updatedAt: "2027",
            isSuperAdmin: true,
            productsCount: 15,
          ),
          CategoryModel(
            id: "673c46fd1159920185",
            name: "crowns",
            slug: "crowns",
            image: "crown image",
            createdAt: "2120",
            updatedAt: "2200",
            isSuperAdmin: true,
            productsCount: 300,
          ),
        ];
        final expectedCategoriesResponse = CategoriesResponse(
          message: "success",
          categories: expectedListOfCategories,
        );
        final expectedCategoriesResult = Success(
          expectedCategoriesResponse.categories!
              .map((category) => category.toCategoryEntity())
              .toList(),
        );
        provideDummy<Result<List<CategoryEntity>?>>(expectedCategoriesResult);
        when(
          mockedConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.wifi]);
        when(
          mockApiClient.fetchAllCategories(),
        ).thenAnswer((_) async => expectedCategoriesResponse);

        // Act
        final result = await categoriesRemoteDataSource.getAllCategories();
        final successResult = result as Success<List<CategoryEntity>?>;

        // Assert
        expect(result, isA<Success<List<CategoryEntity>?>>());
        verify(mockApiClient.fetchAllCategories()).called(1);
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
      'when call getAllProducts it should be called successfully from apiClient and return List<ProductCardEntity>',
      () async {
        // Arrange

        final List<ProductCardModel> expectedListOfProducts = [
          ProductCardModel(
            rateAvg: 4,
            rateCount: 120,
            id: "64a1f9c1b1234567890abcd1",
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
            category: "flowers",
            occasion: "valentine",
            createdAt: "2025-09-01T10:00:00Z",
            updatedAt: "2025-09-01T12:00:00Z",
            v: 1,
            isSuperAdmin: false,
            sold: 20,
            productId: "P001",
          ),
          ProductCardModel(
            rateAvg: 5,
            rateCount: 200,
            id: "64a1f9c1b1234567890abcd2",
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
            category: "gifts",
            occasion: "birthday",
            createdAt: "2025-09-02T09:30:00Z",
            updatedAt: "2025-09-02T11:00:00Z",
            v: 1,
            isSuperAdmin: false,
            sold: 45,
            productId: "P002",
          ),
        ];
        final expectedProductsResponse = ProductsResponse(
          message: "success",
          products: expectedListOfProducts,
        );
        final expectedProductsResult = Success(
          expectedProductsResponse.products!
              .map((product) => product.toProductCardEntity())
              .toList(),
        );
        provideDummy<Result<List<ProductCardEntity>?>>(expectedProductsResult);
        when(
          mockedConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.wifi]);
        when(
          mockApiClient.fetchAllProducts(),
        ).thenAnswer((_) async => expectedProductsResponse);

        // Act
        final result = await categoriesRemoteDataSource.getAllProducts();
        final successResult = result as Success<List<ProductCardEntity>?>;

        // Assert
        expect(result, isA<Success<List<ProductCardEntity>?>>());
        verify(mockApiClient.fetchAllProducts()).called(1);
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
