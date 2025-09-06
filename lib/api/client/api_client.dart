import 'package:dio/dio.dart';
import 'package:flowery_app/api/requests/add_to_cart_request/add_to_cart_request_model.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/api/responses/categories_response/categories_response.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/api/responses/home_products/products_response_model.dart';
import 'package:flowery_app/api/responses/login_response/login_response.dart';
import 'package:flowery_app/api/responses/products_response/products_response.dart';
import 'package:flowery_app/api/responses/profile_response/profile_response.dart';
import 'package:flowery_app/api/responses/register_response/register_response.dart';
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

  @GET(Endpoints.loggedUserData)
  Future<ProfileResponse> getUserData({
    @Header("Authorization") required String token,
  });

  @GET(Endpoints.logout)
  Future<void> logout({@Header("Authorization") required String token});

  @POST(Endpoints.addProductToCart)
  Future<void> addProductToCart({
    @Header("Authorization") required String token,
    @Body() required AddToCartRequestModel request,
  });
}
