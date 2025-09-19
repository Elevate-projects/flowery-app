import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class EditProfileRepository {
  Future<Result<UserDataEntity>> editProfile(EditProfileRequestEntity request);
}