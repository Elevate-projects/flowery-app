import '../../../api/client/api_result.dart';
import '../../entities/verification/request/verify_requset.dart';
import '../../entities/verification/response/verify_response.dart';

abstract interface class VerificationRepository {
  Future<Result<VerifyResponseEntity>> verify(VerifyRequsetEntity request);
}
