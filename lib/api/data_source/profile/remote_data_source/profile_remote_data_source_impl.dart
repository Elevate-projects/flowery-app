import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;
  const ProfileRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<UserDataEntity?>> fetchUserData() async {
    return executeApi(() async {
      final response = await _apiClient.getUserData(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
      return response.userData?.toUserDataEntity();
    });
  }
}
