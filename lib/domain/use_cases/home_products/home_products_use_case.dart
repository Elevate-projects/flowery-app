import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/home_products/home_products_repository.dart';

class HomeProductsUseCase {
  final HomeProductsRepository repository;

  HomeProductsUseCase({required this.repository});

  Future<Result<ProductsResponseEntity>> invoke() async {
    return await repository.getHomeProducts();
  }
}
