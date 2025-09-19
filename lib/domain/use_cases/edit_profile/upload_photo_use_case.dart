import 'dart:io';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/domain/repositories/edit_profile/upload_photo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final UploadPhotoRepository _repository;

  UploadPhotoUseCase(this._repository);

  Future<Result<UploadPhotoResponseEntity>> invoke({required File photoFile}) {
    return _repository.uploadPhoto(photoFile);
  }
}
