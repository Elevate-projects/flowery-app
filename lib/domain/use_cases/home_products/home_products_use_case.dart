import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/home_products/home_products_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeProductsUseCase {
  final HomeProductsRepository _repository;

  const HomeProductsUseCase(this._repository);

  Future<Result<ProductsResponseEntity>> invoke() async {
    return await _repository.getHomeProducts();
  }
}
