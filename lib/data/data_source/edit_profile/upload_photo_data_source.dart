import 'dart:io';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/upload_photo_request_entity.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';

abstract class UploadPhotoDataSource {
  Future<Result<UploadPhotoResponseEntity>> uploadPhoto(File photoFile);
}
