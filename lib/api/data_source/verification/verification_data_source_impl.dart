import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/mapper/mapper.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
import 'package:flowery_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerificationDataSource)
class VreificationDataSourceImpl implements VerificationDataSource {
  ApiClient apiClient;

  @factoryMethod
  VreificationDataSourceImpl(this.apiClient);

  @override
  Future<Result<VerifyResponseEntity>> verify(
    VerifyRequsetEntity request,
  ) async {
    return executeApi(() async {
      var res = await apiClient.verificationCode(Mapper.verifyToDto(request));
      return Mapper.verifyToEntity(VerifyResponseDto());
    });
  }
}
