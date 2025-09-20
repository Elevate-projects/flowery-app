import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/repositories/categories/categories_repository.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_categories_use_case_test.mocks.dart';

@GenerateMocks([CategoriesRepository])
void main() {
  test(
    'when call getAllCategories it should be called successfully from CategoriesRemoteDataSource and return List<CategoryEntity>',
    () async {
      // Arrange
      final mockedCategoriesRepository = MockCategoriesRepository();
      final getAllCategoriesUseCase = GetAllCategoriesUseCase(
        mockedCategoriesRepository,
      );
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
        mockedCategoriesRepository.getAllCategories(),
      ).thenAnswer((_) async => expectedCategoriesResult);

      // Act
      final result = await getAllCategoriesUseCase.invoke();
      final successResult = result as Success<List<CategoryEntity>?>;

      // Assert
      expect(result, isA<Success<List<CategoryEntity>?>>());
      verify(mockedCategoriesRepository.getAllCategories()).called(1);
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
}
