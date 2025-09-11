import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/resend_code/resend_code_data_source.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResendCodeDataSource)
class ResendCodeDataSourceImpl implements ResendCodeDataSource {
  final ApiClient _apiClient;

  @factoryMethod
  ResendCodeDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  ) async {
    return executeApi(() async {
      final res = await _apiClient.resendCode(RequestMapper.resendCodeToDto(request));
      return RequestMapper.resendCodeToEntity(res);
    });
  }
}
