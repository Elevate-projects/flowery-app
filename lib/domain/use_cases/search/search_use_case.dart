import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUseCase {
  final SearchRepo _searchRepo;
  const SearchUseCase(this._searchRepo);
  Future<Result<List<ProductCardEntity>>> invoke({
    required String search,
  }) async {
    return await _searchRepo.searchProducts(search: search);
  }
}
