import 'package:flowery_app/api/dto/verification/response/verify_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/verification/verification_data_source.dart';
import '../../../domain/entities/verification/request/verify_requset.dart';
import '../../../domain/entities/verification/response/verify_response.dart';
import '../../client/api_client.dart';
import '../../client/api_result.dart';
import '../../dto/verification/request/verify_request_dto.dart';

@Injectable(as: VerificationDataSource)
class VreificationDataSourceImpl implements VerificationDataSource {
  ApiClient apiClient;

  @factoryMethod
  VreificationDataSourceImpl(this.apiClient);

  @override
  Future<Result<VerifyResponseEntity>> verify(
    VerifyRequsetEntity request,
  ) async {
    var res = await executeApi(
      () => apiClient.verificationCode(VerifyRequestDto.toDto(request)),
    );
    switch (res) {
      case Success<VerifyResponseDto>():
        return Success(VerifyResponseDto.toEntity(res.data));
      case Failure<VerifyResponseDto>():
        return Failure(responseException: res.responseException);
    }
  }
}
