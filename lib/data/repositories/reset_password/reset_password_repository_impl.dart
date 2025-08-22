import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../../domain/entities/reset_password/request/reset_password_request.dart';
import '../../../domain/entities/reset_password/response/reset_password_response.dart';
import '../../../domain/repositories/reset_password/reset_password_repository.dart';
import '../../data_source/reset_password/reset_password_data_source.dart';

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
