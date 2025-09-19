import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileResetPasswordRepository)
class ProfileResetPasswordRepositoryImpl implements ProfileResetPasswordRepository {
  final ProfileResetPasswordDataSource _dataSource;

  ProfileResetPasswordRepositoryImpl(this._dataSource);

  @override
  Future<Result<ProfileResetPasswordResponseEntity>> resetPassword({
    required ProfileResetPasswordRequestEntity entity,
  }) async {
    return await _dataSource.resetPassword(
      entity: entity,
    );
  }
}
