import 'package:dio/dio.dart';
import 'package:flowery_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/resend_code/request/resend_code_request_dto.dart';
import '../dto/resend_code/response/resend_code_response_dto.dart';
import '../dto/reset_password/request/reset_password_request_dto.dart';
import '../dto/reset_password/response/reset_password_response_dto.dart';
import '../dto/verification/request/verify_request_dto.dart';
import '../dto/verification/response/verify_response_dto.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  // @POST(Endpoints.login)
  // Future<LoginResponse> login({@Body() required LoginRequest request});

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
