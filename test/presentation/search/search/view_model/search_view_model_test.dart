import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/search/search_use_case.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_intent.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_state.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';

import 'search_view_model_test.mocks.dart';

@GenerateMocks([SearchUseCase])
void main() {
  provideDummy<Result<List<ProductCardEntity>>>(
    Success<List<ProductCardEntity>>([]),
  );

  late MockSearchUseCase mockSearchUseCase;
  late SearchViewModel viewModel;

  setUp(() {
    mockSearchUseCase = MockSearchUseCase();
    viewModel = SearchViewModel(mockSearchUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group('SearchViewModel Tests', () {
    test(
      'should emit [Loading, Success] when search succeeds with products',
      () async {
        // Arrange
        const searchQuery = "cake";
        final mockProducts = [
          const ProductCardEntity(productId: "1", title: "Chocolate Cake"),
          const ProductCardEntity(productId: "2", title: "Strawberry Cake"),
        ];

        when(mockSearchUseCase.invoke(search: searchQuery)).thenAnswer(
          (_) async => Success<List<ProductCardEntity>>(mockProducts),
        );

        // Act
        viewModel.doIntent(OnSearchClick(search: searchQuery));

        // Assert
        await expectLater(
          viewModel.stream,
          emitsInOrder([
            isA<SearchLoadingState>(),
            isA<SearchSuccessState>().having(
              (s) => s.products.length,
              'products length',
              2,
            ),
          ]),
        );
      },
    );

    test(
      'should emit [Loading, Empty] when search succeeds with empty list',
      () async {
        // Arrange
        const searchQuery = "unknown";

        when(
          mockSearchUseCase.invoke(search: searchQuery),
        ).thenAnswer((_) async => Success<List<ProductCardEntity>>([]));

        // Act
        viewModel.doIntent(OnSearchClick(search: searchQuery));

        // Assert
        await expectLater(
          viewModel.stream,
          emitsInOrder([isA<SearchLoadingState>(), isA<SearchEmptyState>()]),
        );
      },
    );

    test('should emit [Loading, Failure] when search fails', () async {
      // Arrange
      const searchQuery = "flowers";

      when(mockSearchUseCase.invoke(search: searchQuery)).thenAnswer(
        (_) async => Failure<List<ProductCardEntity>>(
          responseException: const ResponseException(message: "API error"),
        ),
      );

      // Act
      viewModel.doIntent(OnSearchClick(search: searchQuery));

      // Assert
      await expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<SearchLoadingState>(),
          isA<SearchFailureState>().having(
            (s) => s.error,
            'error message',
            "API error",
          ),
        ]),
      );
    });
  });
}
