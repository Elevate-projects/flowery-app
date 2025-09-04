import 'package:dio/dio.dart';
import 'package:flowery_app/api/responses/home_products/products_response_model.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
@GET(Endpoints.home)
Future<ProductsResponseModel> getHomeData({@Header("Authorization") required String token});

}
