import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/categories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase {
  final CategoriesRepository _categoriesRepository;
  const GetAllProductsUseCase(this._categoriesRepository);

  Future<Result<List<ProductCardEntity>?>> invoke() async {
    return await _categoriesRepository.getAllProducts();
  }
}
