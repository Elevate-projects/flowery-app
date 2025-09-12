import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/home_products/home_products_data_source.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeProductsDataSource)
class HomeProductsDataSourceImpl implements HomeProductsDataSource {
  final ApiClient _apiClient;

  const HomeProductsDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProductsResponseEntity>> getHomeProducts() async {
    return await executeApi(() async {
      final response = await _apiClient.getHomeData(
        token: 'Bearer ${FloweryMethodHelper.currentUserToken}',
      );
      return response.toEntity();
    });
  }
}
