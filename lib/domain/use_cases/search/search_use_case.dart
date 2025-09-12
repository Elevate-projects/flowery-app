import 'package:flowery_app/api/client/api_result.dart';
 import 'package:flowery_app/domain/entities/search/response/search_response_entity.dart';
import 'package:flowery_app/domain/repositories/search/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUseCase{
  final SearchRepo _searchRepo;
  SearchUseCase(this._searchRepo);
  Future<Result<SearchResponseEntity>>call({required String search}){
    return _searchRepo.searchProducts(search: search);
  }

}