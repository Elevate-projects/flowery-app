import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/search_data_source/search_data_source.dart';
 import 'package:flowery_app/domain/entities/search/response/search_response_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:SearchDataSource )
class SearchDataSourceImpl implements SearchDataSource{
 final ApiClient _apiClient;
 SearchDataSourceImpl(this._apiClient);
  @override
  Future<Result<SearchResponseEntity>> searchProducts(
      {required String search}) async{
     return executeApi(()async{
       final res = await _apiClient.searchProducts(search: search);
       return RequestMapper.searchToEntity(res);

     });
  }
}