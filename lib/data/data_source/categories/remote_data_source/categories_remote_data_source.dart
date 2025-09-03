import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

abstract class CategoriesRemoteDataSource {
  Future<Result<List<CategoryEntity>?>> getAllCategories();
  Future<Result<List<ProductCardEntity>?>> getAllProducts();
}
