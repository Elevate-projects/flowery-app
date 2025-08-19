import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../../domain/entities/verification/request/verify_requset.dart';
import '../../../domain/entities/verification/response/verify_response.dart';
import '../../../domain/repositories/verification/verification_repository.dart';
import '../../data_source/verification/verification_data_source.dart';

@Injectable(as: VerificationRepository)
class VreificationRepositoryImpl implements VerificationRepository {
  VerificationDataSource _verificationDataSource;

  VreificationRepositoryImpl(this._verificationDataSource);

  @override
  Future<Result<VerifyResponseEntity>> verify(VerifyRequsetEntity request) {
    return _verificationDataSource.verify(request);
  }
}
