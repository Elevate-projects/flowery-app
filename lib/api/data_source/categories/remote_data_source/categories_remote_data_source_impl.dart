import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/categories/remote_data_source/categories_remote_data_source.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiClient _apiClient;
  const CategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<List<CategoryEntity>?>> getAllCategories() async {
    return await executeApi(() async {
      final result = await _apiClient.fetchAllCategories();
      return result.categories
          ?.map((category) => category.toCategoryEntity())
          .toList();
    });
  }

  @override
  Future<Result<List<ProductCardEntity>?>> getAllProducts() async {
    return await executeApi(() async {
      final result = await _apiClient.fetchAllProducts();
      return result.products
          ?.map((product) => product.toProductCardEntity())
          .toList();
    });
  }
}
