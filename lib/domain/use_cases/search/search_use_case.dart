import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUseCase{
  final SearchRepo _searchRepo;
  SearchUseCase(this._searchRepo);
  Future<Result<ProductsResponseEntity>>call(String productId){
    return _searchRepo.getProductBySearch(productId);
  }

}