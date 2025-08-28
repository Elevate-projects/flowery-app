import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/data/data_source/home_products/home_products_data_source.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';

class HomeProductsSourceImpl implements HomeProductsDataSource {
  final ApiClient apiClient;

  HomeProductsSourceImpl({required this.apiClient});

  @override
  Future<Result<ProductsResponseEntity>> getHomeProducts() async {
     return await executeApi(() async {
       final response = await apiClient.getHomeData(token: AppText.bearerToken);
       return response.toEntity();
     });
  }
}
