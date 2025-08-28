import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/home_products/home_products_data_source.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/home_products/home_products_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeProductsRepository)
class HomeProductsRepositoryImpl implements HomeProductsRepository {
  final HomeProductsDataSource _dataSource;

  HomeProductsRepositoryImpl(this._dataSource);

  @override
  Future<Result<ProductsResponseEntity>> getHomeProducts() async {
    return await _dataSource.getHomeProducts();
  }
}
