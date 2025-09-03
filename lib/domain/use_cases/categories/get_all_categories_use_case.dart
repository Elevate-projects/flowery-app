import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/repositories/categories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase {
  final CategoriesRepository _categoriesRepository;
  const GetAllCategoriesUseCase(this._categoriesRepository);

  Future<Result<List<CategoryEntity>?>> invoke() async {
    return await _categoriesRepository.getAllCategories();
  }
}
