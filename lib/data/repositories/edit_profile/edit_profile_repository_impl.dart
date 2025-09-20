import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/edit_profile/edit_profile_data_source.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileDataSource _dataSource;

  EditProfileRepositoryImpl(this._dataSource);

  @override
  Future<Result<UserDataEntity>> editProfile(EditProfileRequestEntity request) {
    return _dataSource.editProfile(request);
  }
}
