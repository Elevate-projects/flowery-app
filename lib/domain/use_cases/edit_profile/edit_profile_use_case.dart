import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileUseCase {
  final EditProfileRepository _repository;

  EditProfileUseCase(this._repository);

  Future<Result<UserDataEntity>> invoke({required EditProfileRequestEntity request}) async {
    return await _repository.editProfile(request);
  }
}
