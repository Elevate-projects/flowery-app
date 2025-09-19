import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileResetPasswordUseCase {
  final ProfileResetPasswordRepository repository;

  ProfileResetPasswordUseCase({required this.repository});

  Future<Result<ProfileResetPasswordResponseEntity>> call({
    required ProfileResetPasswordRequestEntity entity,
  }) async {
    return await repository.resetPassword(entity: entity);
  }
}
