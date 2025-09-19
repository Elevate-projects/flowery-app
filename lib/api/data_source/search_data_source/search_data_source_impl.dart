import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/search_data_source/search_data_source.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  final ApiClient _apiClient;
  SearchDataSourceImpl(this._apiClient);
  @override
  Future<Result<List<ProductCardEntity>>> searchProducts({
    required String search,
  }) async {
    return executeApi(() async {
      final result = await _apiClient.searchProducts(search: search);
      final productsList = result.products
          ?.map((product) => product.toProductCardEntity())
          .toList();

      return productsList ?? [];
    });
  }
}
