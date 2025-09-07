import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  ResetPasswordDataSource resetPasswordDataSource;

  @factoryMethod
  ResetPasswordRepositoryImpl(this.resetPasswordDataSource);

  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return resetPasswordDataSource.resetPassword(request);
  }
}
