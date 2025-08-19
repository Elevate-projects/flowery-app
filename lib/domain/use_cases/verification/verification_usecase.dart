
import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../entities/verification/request/verify_requset.dart';
import '../../entities/verification/response/verify_response.dart';
import '../../repositories/verification/verification_repository.dart';

@injectable
class GetVerificationUsecase {
  VerificationRepository verificationRepository;

  @factoryMethod
  GetVerificationUsecase(this.verificationRepository);

  Future<Result<VerifyResponseEntity>> execute(VerifyRequsetEntity request) {
    return verificationRepository.verify(request);
  }
}
