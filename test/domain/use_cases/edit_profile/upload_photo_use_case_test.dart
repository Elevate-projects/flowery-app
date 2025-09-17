import 'dart:io';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/responses/edit_profile_response/upload_photo_response.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/domain/repositories/edit_profile/upload_photo_repository.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/upload_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_use_case_test.mocks.dart';
@GenerateMocks([UploadPhotoRepository])
void main(){
   TestWidgetsFlutterBinding.ensureInitialized();
test('when call upload photo from uploadPhotoUseCase it should return success',()async{
  final mockUploadPhotoRepository = MockUploadPhotoRepository();
final uploadPhotoUseCase = UploadPhotoUseCase(mockUploadPhotoRepository);
final expectedResponse = const UploadPhotoResponse(message: 'success');
    final photoFilePath = File('path/to/photo.jpg');
    final expectedSuccessUploadPhotoResponseEntity = Success(expectedResponse.toUploadPhotoResponseEntity());
    provideDummy<Result<UploadPhotoResponseEntity>>(expectedSuccessUploadPhotoResponseEntity);
    when(mockUploadPhotoRepository.uploadPhoto(photoFilePath)).thenAnswer((_)async => expectedSuccessUploadPhotoResponseEntity);
    //Act
    final result = await uploadPhotoUseCase.invoke(photoFile: photoFilePath);
    final successResult = result as Success<UploadPhotoResponseEntity>;
    //Assert
    expect(result,isA<Success<UploadPhotoResponseEntity>>());
    verify(mockUploadPhotoRepository.uploadPhoto(photoFilePath)).called(1);
     expect(successResult.data.message, expectedSuccessUploadPhotoResponseEntity.data.message);
});
}