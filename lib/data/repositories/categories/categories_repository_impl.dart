import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/categories/remote_data_source/categories_remote_data_source.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/categories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;
  const CategoriesRepositoryImpl(this._categoriesRemoteDataSource);
  @override
  Future<Result<List<CategoryEntity>?>> getAllCategories() async {
    return await _categoriesRemoteDataSource.getAllCategories();
  }

  @override
  Future<Result<List<ProductCardEntity>?>> getAllProducts() async {
    return await _categoriesRemoteDataSource.getAllProducts();
  }
}
