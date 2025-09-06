import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flowery_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: VerificationRepository)
class VerificationRepositoryImpl implements VerificationRepository {
  final VerificationDataSource _verificationDataSource;

  VerificationRepositoryImpl(this._verificationDataSource);

  @override
  Future<Result<VerifyResponseEntity>> verify(VerifyRequestEntity request) {
    return _verificationDataSource.verify(request);
  }
}
