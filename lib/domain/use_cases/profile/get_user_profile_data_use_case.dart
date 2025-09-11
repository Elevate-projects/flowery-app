import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserProfileDataUseCase {
  final ProfileRepository _profileRepository;
  const GetUserProfileDataUseCase(this._profileRepository);
  Future<Result<UserDataEntity?>> invoke() async {
    return await _profileRepository.fetchUserData();
  }
}
