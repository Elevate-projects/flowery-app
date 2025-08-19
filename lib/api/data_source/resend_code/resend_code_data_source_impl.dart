import 'package:flowery_app/api/dto/resend_code/response/resend_code_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/resend_code/resend_code_data_source.dart';
import '../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../domain/entities/resend_code/response/resend_code_response.dart';
import '../../client/api_client.dart';
import '../../client/api_result.dart';
import '../../dto/resend_code/request/resend_code_request_dto.dart';

@Injectable(as: ResendCodeDataSource)
class ResendCodeDataSourceImpl implements ResendCodeDataSource {
  ApiClient _apiClient;

  @factoryMethod
  ResendCodeDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  ) async {
    var res = await executeApi(
      () => _apiClient.resendCode(ResendCodeRequestDto.toDto(request)),
    );
    switch (res) {
      case Success<ResendCodeResponseDto>():
        return Success(ResendCodeResponseDto.toEntity(res.data));
      case Failure<ResendCodeResponseDto>():
        return Failure(responseException: res.responseException);
    }
  }
}
