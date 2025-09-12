  import 'package:flowery_app/api/client/api_client.dart';
  import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
  import 'package:flowery_app/api/responses/edit_profile_response/edit_profile_response.dart';
  import 'package:flowery_app/data/data_source/edit_profile/edit_profile_data_source.dart';
  import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
  import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileDataSource)
class EditProfileDataSourceImpl  implements EditProfileDataSource{
    final ApiClient _apiClient;

    EditProfileDataSourceImpl(this._apiClient);

    @override
    Future<Result<UserDataEntity>> editProfile(EditProfileRequestEntity request) async {
       return executeApi(() async {
      final response = await _apiClient.editUserProfile(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        request: RequestMapper.toEditProfileRequestEntity(entity: request),
      );
      final userData = response.userData?.toUserDataEntity();
      return userData!;
    });
    }
  }