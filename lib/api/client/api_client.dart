import 'package:dio/dio.dart';
import 'package:flowery_app/api/responses/splash_response/splash_response.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(Endpoints.getLoggedUserData)
  Future<SplashResponse> getUserData({
    @Header("Authorization") required String token,
  });
}
