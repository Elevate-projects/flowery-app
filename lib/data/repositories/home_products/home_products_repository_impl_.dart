import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/home_products/home_products_data_source.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/home_products/home_products_repository.dart';

class HomeProductsRepositoryImpl implements HomeProductsRepository {
  final HomeProductsDataSource dataSource;

  HomeProductsRepositoryImpl({required this.dataSource});

  @override
  Future<Result<ProductsResponseEntity>> getHomeProducts() async {
    return await dataSource.getHomeProducts();
  }
}
