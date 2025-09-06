import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordDataSource _dataSource;

  ResetPasswordRepositoryImpl(this._dataSource);

  @override
  Future<Result<void>> resetPassword({
    required ResetPasswordRequestEntity entity,
  }) async {
    return await _dataSource.resetPassword(
      entity: entity,
    );
  }
}
