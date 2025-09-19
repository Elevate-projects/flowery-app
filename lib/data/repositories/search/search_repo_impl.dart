import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/search_data_source/search_data_source.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchDataSource _searchDataSource;
  SearchRepoImpl(this._searchDataSource);
  @override
  Future<Result<List<ProductCardEntity>>> searchProducts({
    required String search,
  }) async {
    return await _searchDataSource.searchProducts(search: search);
  }
}
