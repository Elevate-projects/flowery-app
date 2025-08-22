
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
 import 'package:flowery_app/domain/repositories/forget_password/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:ForgetPasswordRepo )
class ForgetPasswordRepoImpl extends ForgetPasswordRepo{
  ForgetPasswordRemoteDataSource   _forgetPasswordRemoteDataSource;
  ForgetPasswordRepoImpl(this._forgetPasswordRemoteDataSource);
  @override
  Future<Result<ForgetPasswordResponseEntity>> getForgetPassword(ForgetPasswordRequestEntity request) {
     return _forgetPasswordRemoteDataSource.getForgetPassword(request);
  }
}