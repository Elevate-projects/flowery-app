import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';

abstract interface class VerificationRepository {
  Future<Result<VerifyResponseEntity>> verify(VerifyRequestEntity request);
}
