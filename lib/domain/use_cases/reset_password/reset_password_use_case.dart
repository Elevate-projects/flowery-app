import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ResetPasswordUseCase  {
  final ResetPasswordRepository repository;


  ResetPasswordUseCase({required this.repository});

  Future<Result<ResetPasswordResponseEntity>> call({
    required ResetPasswordRequestEntity entity,
  }) async {
    return await repository.resetPassword(entity: entity);
  }
}