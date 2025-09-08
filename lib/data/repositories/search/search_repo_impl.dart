import 'package:flowery_app/api/client/api_result.dart';
 import 'package:flowery_app/data/data_source/search_data_source/search_data_source.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: SearchRepo)
class SearchRepoImpl implements SearchRepo{
 final SearchDataSource _searchDataSource;
 SearchRepoImpl(this._searchDataSource);
  @override
  Future<Result<ProductsResponseEntity>> getProductBySearch(String productId) {
    return _searchDataSource.getProductBySearch(productId);
  }
}