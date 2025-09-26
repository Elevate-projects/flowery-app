
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/data/data_source/search_data_source/search_data_source.dart';
import 'package:flowery_app/data/repositories/search/search_repo_impl.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

import 'search_repo_impl_test.mocks.dart';

@GenerateMocks([SearchDataSource])
void main() {
  provideDummy<Result<List<ProductCardEntity>>>(
    Success<List<ProductCardEntity>>([]),
  );

  late MockSearchDataSource mockSearchDataSource;
  late SearchRepoImpl searchRepo;

  setUp(() {
    mockSearchDataSource = MockSearchDataSource();
    searchRepo = SearchRepoImpl(mockSearchDataSource);
  });

  group('SearchRepoImpl Tests', () {
    test(
        'should return Success<List<ProductCardEntity>> when DataSource succeeds',
            () async {
          // Arrange
          const searchQuery = 'cake';

          final mockProducts = [
            const ProductCardEntity(productId: "1", title: "Chocolate Cake"),
            const ProductCardEntity(productId: "2", title: "Strawberry Cake"),
          ];

          final mockResult = Success<List<ProductCardEntity>>(mockProducts);

          when(mockSearchDataSource.searchProducts(search: searchQuery))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await searchRepo.searchProducts(search: searchQuery);

          // Assert
          expect(result, isA<Success<List<ProductCardEntity>>>());

          final success = result as Success<List<ProductCardEntity>>;
          expect(success.data.length, 2);
          expect(success.data.first.title, "Chocolate Cake");

          verify(mockSearchDataSource.searchProducts(search: searchQuery)).called(1);
        });

    test('should return Failure when DataSource fails', () async {
      // Arrange
      const searchQuery = 'flowers';

      final mockResult = Failure<List<ProductCardEntity>>(
        responseException: const ResponseException(message: "API error"),
      );

      when(mockSearchDataSource.searchProducts(search: searchQuery))
          .thenAnswer((_) async => mockResult);

      // Act
      final result = await searchRepo.searchProducts(search: searchQuery);

      // Assert
      expect(result, isA<Failure<List<ProductCardEntity>>>());
      expect(
        (result as Failure<List<ProductCardEntity>>).responseException.message,
        "API error",
      );

      verify(mockSearchDataSource.searchProducts(search: searchQuery)).called(1);
    });
  });
}

