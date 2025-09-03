import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/repositories/forget_password/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ForgetPasswordRemoteDataSource _forgetPasswordRemoteDataSource;
  ForgetPasswordRepoImpl(this._forgetPasswordRemoteDataSource);
  @override
  Future<Result<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    return _forgetPasswordRemoteDataSource.forgetPassword(request);
  }
}
