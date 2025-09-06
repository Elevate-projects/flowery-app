import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flowery_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVerificationUseCase {
  VerificationRepository verificationRepository;

  @factoryMethod
  GetVerificationUseCase(this.verificationRepository);

  Future<Result<VerifyResponseEntity>> execute(VerifyRequestEntity request) {
    return verificationRepository.verify(request);
  }
}
