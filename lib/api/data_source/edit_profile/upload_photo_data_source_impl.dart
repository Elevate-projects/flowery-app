import 'dart:io';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/edit_profile/upload_photo_data_source.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: UploadPhotoDataSource)
class UploadPhotoDataSourceImpl  implements UploadPhotoDataSource{
  final ApiClient _apiClient;
  UploadPhotoDataSourceImpl(this._apiClient);
  @override
  Future<Result<UploadPhotoResponseEntity>> uploadPhoto(File photoFile) {
    return executeApi(() async {
      final response = await _apiClient.uploadProfilePhoto(
        token:"Bearer ${FloweryMethodHelper.currentUserToken}" ,
        photo: photoFile
      );
      final responseData= response.toUploadPhotoResponseEntity();
      return responseData;
    });
  }
}