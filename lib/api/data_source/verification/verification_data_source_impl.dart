import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerificationDataSource)
class VerificationDataSourceImpl implements VerificationDataSource {
  ApiClient apiClient;

  @factoryMethod
  VerificationDataSourceImpl(this.apiClient);

  @override
  Future<Result<VerifyResponseEntity>> verify(
    VerifyRequestEntity request,
  ) async {
    return executeApi(() async {
      final res = await apiClient.verificationCode(
        RequestMapper.verifyToDto(request),
      );
      return RequestMapper.verifyToEntity(res);
    });
  }
}
