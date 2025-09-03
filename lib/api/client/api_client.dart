import 'package:dio/dio.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/api/responses/categories_response/categories_response.dart';
import 'package:flowery_app/api/responses/login_response/login_response.dart';
import 'package:flowery_app/api/responses/products_response/products_response.dart';
import 'package:flowery_app/api/responses/register_response/register_response.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../requests/cart_request/cart_request.dart';
import '../responses/cart_response/cart_response.dart';
import '../responses/cart_response/get_logged_user_cart.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.login)
  Future<LoginResponse> login({@Body() required LoginRequestModel request});

  @POST(Endpoints.register)
  Future<RegisterResponse> register({@Body() required RegisterRequest request});

  @GET(Endpoints.categories)
  Future<CategoriesResponse> fetchAllCategories();

  @GET(Endpoints.products)
  Future<ProductsResponse> fetchAllProducts();

  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponseModel> forgetPassword( {@Body() required ForgetPasswordRequestDto request});

  @POST(Endpoints.cartPage)
  Future<CartResponse> cartPage({
    @Header("Authorization") required String token,
    @Body() required CartRequest request});
  @GET(Endpoints.getLoggedUserCart)
  Future<GetLoggedUserCart> getLoggedUserCart({
    @Header("Authorization") required String token,
});
}
