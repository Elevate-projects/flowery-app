import 'package:dio/dio.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  // @POST(Endpoints.login)
// Future<LoginResponse> login({@Body() required LoginRequest request});

  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponseDto> forgetPassword( {@Body() required ForgetPasswordRequestDto request});

}
