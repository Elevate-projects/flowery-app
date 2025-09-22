
import 'package:flowery_app/domain/use_cases/search/search_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';

import 'search_use_case_test.mocks.dart';

@GenerateMocks([SearchRepo])
void main() {
  provideDummy<Result<List<ProductCardEntity>>>(
    Success<List<ProductCardEntity>>([]),
  );

  late MockSearchRepo mockSearchRepo;
  late SearchUseCase searchUseCase;

  setUp(() {
    mockSearchRepo = MockSearchRepo();
    searchUseCase = SearchUseCase(mockSearchRepo);
  });

  group('SearchUseCase Tests', () {
    test('should return Success<List<ProductCardEntity>> when Repo succeeds',
            () async {
          // Arrange
          const searchQuery = 'cake';
          final mockProducts = [
            const ProductCardEntity(productId: "1", title: "Chocolate Cake"),
            const ProductCardEntity(productId: "2", title: "Strawberry Cake"),
          ];
          final mockResult = Success<List<ProductCardEntity>>(mockProducts);

          when(mockSearchRepo.searchProducts(search: searchQuery))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await searchUseCase.invoke(search: searchQuery);

          // Assert
          expect(result, isA<Success<List<ProductCardEntity>>>());
          final success = result as Success<List<ProductCardEntity>>;
          expect(success.data.length, 2);
          expect(success.data.first.title, "Chocolate Cake");

          verify(mockSearchRepo.searchProducts(search: searchQuery)).called(1);
        });

    test('should return Failure when Repo fails', () async {
      // Arrange
      const searchQuery = 'flowers';
      final mockResult = Failure<List<ProductCardEntity>>(
        responseException: const ResponseException(message: "API error"),
      );

      when(mockSearchRepo.searchProducts(search: searchQuery))
          .thenAnswer((_) async => mockResult);

      // Act
      final result = await searchUseCase.invoke(search: searchQuery);

      // Assert
      expect(result, isA<Failure<List<ProductCardEntity>>>());
      expect(
        (result as Failure<List<ProductCardEntity>>).responseException.message,
        "API error",
      );

      verify(mockSearchRepo.searchProducts(search: searchQuery)).called(1);
    });
  });
}
