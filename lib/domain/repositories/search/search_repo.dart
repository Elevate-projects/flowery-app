import 'package:flowery_app/api/client/api_result.dart';
 import 'package:flowery_app/domain/entities/search/response/search_response_entity.dart';

abstract interface class SearchRepo{
  Future<Result<SearchResponseEntity>> searchProducts({required String search});
}