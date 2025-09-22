import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/search_data_source/search_data_source_impl.dart';
import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/api/responses/search/search_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockApiClient mockApiClient;
  late SearchDataSourceImpl searchDataSource;
  final mockConnectivity = MockConnectivity();
  ConnectionManager.connectivity = mockConnectivity;

  setUp(() {
    mockApiClient = MockApiClient();
    searchDataSource = SearchDataSourceImpl(mockApiClient);
  });

  test('should return Success<List<ProductCardEntity>> when API call succeeds', () async {
    const searchQuery = 'cake';

    final mockProducts = [
      ProductCardModel(id: "1", title: "Chocolate Cake", price: 50),
      ProductCardModel(id: "2", title: "Strawberry Cake", price: 70),
    ];

    final mockResponse = SearchResponse(products: mockProducts);

    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(mockApiClient.searchProducts(search: searchQuery))
        .thenAnswer((_) async => mockResponse);

    final result = await searchDataSource.searchProducts(search: searchQuery);

    verify(mockApiClient.searchProducts(search: searchQuery)).called(1);

    expect(result, isA<Success<List<ProductCardEntity>>>());
    final success = result as Success<List<ProductCardEntity>>;
    expect(success.data.length, 2);
    expect(success.data.first.title, "Chocolate Cake");
  });


}
