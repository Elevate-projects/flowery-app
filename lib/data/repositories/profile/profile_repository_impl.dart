import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  const ProfileRepositoryImpl(this._profileRemoteDataSource);
  @override
  Future<Result<UserDataEntity?>> fetchUserData() async {
    return await _profileRemoteDataSource.fetchUserData();
  }
}
