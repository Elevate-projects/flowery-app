import 'package:dio/dio.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/api/requests/resend_code/resend_code_request_dto.dart';
import 'package:flowery_app/api/requests/reset_password/reset_password_request_dto.dart';
import 'package:flowery_app/api/requests/verification/verify_request_dto.dart';
import 'package:flowery_app/api/responses/categories_response/categories_response.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/api/responses/home_products/products_response_model.dart';
import 'package:flowery_app/api/responses/login_response/login_response.dart';
import 'package:flowery_app/api/responses/products_response/products_response.dart';
import 'package:flowery_app/api/responses/register_response/register_response.dart';
import 'package:flowery_app/api/responses/resend_code/resend_code_response_dto.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response_dto.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
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
  Future<ProductsResponseModel> getHomeData({
    @Header("Authorization") required String token,
  });

  @POST(Endpoints.login)
  Future<LoginResponse> login({@Body() required LoginRequestModel request});

  @POST(Endpoints.register)
  Future<RegisterResponse> register({@Body() required RegisterRequest request});

  @GET(Endpoints.categories)
  Future<CategoriesResponse> fetchAllCategories();

  @GET(Endpoints.products)
  Future<ProductsResponse> fetchAllProducts();

  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponseModel> forgetPassword({
    @Body() required ForgetPasswordRequestDto request,
  });

  @POST(Endpoints.resendCode)
  Future<ResendCodeResponseDto> resendCode(
    @Body() ResendCodeRequestDto request,
  );

  @POST(Endpoints.verification)
  Future<VerifyResponseDto> verificationCode(@Body() VerifyRequestDto request);

  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto request,
  );
}
