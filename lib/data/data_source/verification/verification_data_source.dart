
import '../../../api/client/api_result.dart';
import '../../../domain/entities/verification/request/verify_requset.dart';
import '../../../domain/entities/verification/response/verify_response.dart';

abstract interface class VerificationDataSource {
  Future<Result<VerifyResponseEntity>> verify(VerifyRequsetEntity request);
}
