import 'package:flowery_app/api/dto/mapper/mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/resend_code/resend_code_data_source.dart';
import '../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../domain/entities/resend_code/response/resend_code_response.dart';
import '../../client/api_client.dart';
import '../../client/api_result.dart';

@Injectable(as: ResendCodeDataSource)
class ResendCodeDataSourceImpl implements ResendCodeDataSource {
  ApiClient _apiClient;

  @factoryMethod
  ResendCodeDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  ) async {
    return executeApi(() async {
      var res = await _apiClient.resendCode(Mapper.resendCodeToDto(request));
      return Mapper.resendCodeToEntity(res);
    });
  }
}
