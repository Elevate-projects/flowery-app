import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery_app/api/requests/add_address/add_address_request_model.dart';
import 'package:flowery_app/api/requests/add_to_cart_request/add_to_cart_request_model.dart';
import 'package:flowery_app/api/requests/cart_request/quintity_request.dart';
import 'package:flowery_app/api/requests/edit_profile_request/edit_profile_request.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/payment/payment_request_dto.dart';
import 'package:flowery_app/api/requests/profile_reset_password/profile_reset_password_request.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/api/requests/resend_code/resend_code_request_dto.dart';
import 'package:flowery_app/api/requests/reset_password/reset_password_request_dto.dart';
import 'package:flowery_app/api/requests/verification/verify_request_dto.dart';
import 'package:flowery_app/api/responses/add_address_response/add_address_response.dart';
import 'package:flowery_app/api/responses/cart_response/delete_items.dart';
import 'package:flowery_app/api/responses/cart_response/get_logged_user_cart.dart';
import 'package:flowery_app/api/responses/cart_response/quantity_response.dart';
import 'package:flowery_app/api/responses/categories_response/categories_response.dart';
import 'package:flowery_app/api/responses/edit_profile_response/edit_profile_response.dart';
import 'package:flowery_app/api/responses/edit_profile_response/upload_photo_response.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/api/responses/get_user_order/get_user_order_response.dart';
import 'package:flowery_app/api/responses/home_products/products_response_model.dart';
import 'package:flowery_app/api/responses/login_response/login_response.dart';
import 'package:flowery_app/api/responses/payment/cash/cash_payment_response_dto.dart';
import 'package:flowery_app/api/responses/payment/credit/credit_payment_response_dto.dart';
import 'package:flowery_app/api/responses/products_response/products_response.dart';
import 'package:flowery_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_app/api/responses/profile_response/profile_response.dart';
import 'package:flowery_app/api/responses/register_response/register_response.dart';
import 'package:flowery_app/api/responses/resend_code/resend_code_response_dto.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response_dto.dart';
import 'package:flowery_app/api/responses/search/search_response.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
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

  @GET(Endpoints.loggedUserData)
  Future<ProfileResponse> getUserData({
    @Header("Authorization") required String token,
  });

  @GET(Endpoints.logout)
  Future<void> logout({@Header("Authorization") required String token});

  @POST(Endpoints.verification)
  Future<VerifyResponseDto> verificationCode(@Body() VerifyRequestDto request);

  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto request,
  );

  @GET(Endpoints.products)
  Future<SearchResponse> searchProducts({
    @Query("keyword") required String search,
  });

  @DELETE(Endpoints.removeAddress)
  Future<void> removeAddress({
    @Path("addressId") required String addressId,
    @Header("Authorization") required String token,
  });

  @PATCH(Endpoints.addAddress)
  Future<AddAddressResponse> addAddress({
    @Body() required AddAddressRequestModel request,
    @Header("Authorization") required String token,
  });

  @POST(Endpoints.addProductToCart)
  Future<void> addProductToCart({
    @Header("Authorization") required String token,
    @Body() required AddToCartRequestModel request,
  });
  @GET(Endpoints.getLoggedUserCart)
  Future<GetLoggedUserCartModel> getLoggedUserCart({
    @Header("Authorization") required String token,
  });
  @PUT(Endpoints.updateCartQuantity)
  Future<QuantityResponse> updateCartQuantity({
    @Path("productId") required String productId,
    @Header("Authorization") required String token,
    @Body() required QuantityRequest request,
  });

  @DELETE(Endpoints.deleteCartQuantity)
  Future<DeleteItem> deleteCartQuantity({
    @Path("productId") required String productId,
    @Header("Authorization") required String token,
  });

  @GET(Endpoints.getUserOrder)
  Future<GetUserOrderResponse> getUserOrder({
    @Header("Authorization") required String token,
  });

  @PUT(Endpoints.editProfile)
  Future<EditProfileResponse> editUserProfile({
    @Header("Authorization") required String token,
    @Body() required EditProfileRequest request,
  });

  @PUT(Endpoints.uploadProfileImage)
  @MultiPart()
  Future<UploadPhotoResponse> uploadProfilePhoto({
    @Header("Authorization") required String token,
    @Part(name: "photo") required File photo,
  });

  @PATCH(Endpoints.profileResetPassword)
  Future<ProfileResetPasswordResponse> profileResetPassword({
    @Header("Authorization") required String token,
    @Body() required ProfileResetPasswordRequest entity,
  });

  @POST(Endpoints.payment)
  Future<CreditPaymentResponseDto> creditPayment({
    @Body() required PaymentRequestDto request,
    @Header('Authorization') required String token,
    @Query("url") required String redirectUrl,
  });

  @POST(Endpoints.cash)
  Future<CashPaymentResponseDto> cashPayment({
    @Body() required PaymentRequestDto request,
    @Header('Authorization') required String token,
  });
}
