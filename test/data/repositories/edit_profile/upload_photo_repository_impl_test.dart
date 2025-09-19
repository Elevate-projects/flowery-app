import 'dart:io';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/responses/edit_profile_response/upload_photo_response.dart';
import 'package:flowery_app/data/data_source/edit_profile/upload_photo_data_source.dart';
import 'package:flowery_app/data/repositories/edit_profile/upload_photo_repository_impl.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_repository_impl_test.mocks.dart';
@GenerateMocks([UploadPhotoDataSource])
void main(){
   TestWidgetsFlutterBinding.ensureInitialized();
 test('should be a subclass of UploadPhotoRepository', () async{
   //Arrange
 final mockUploadPhotoDataSource = MockUploadPhotoDataSource();
 final uploadPhotoRepository = UploadPhotoRepositoryImpl(mockUploadPhotoDataSource);
 final expectedResponse = const UploadPhotoResponse(message: 'success');
    final photoFilePath = File('path/to/photo.jpg');
    final expectedSuccessUploadPhotoResponseEntity = Success(expectedResponse.toUploadPhotoResponseEntity());
    provideDummy<Result<UploadPhotoResponseEntity>>(expectedSuccessUploadPhotoResponseEntity);
    when(mockUploadPhotoDataSource.uploadPhoto(photoFilePath)).thenAnswer((_)async => expectedSuccessUploadPhotoResponseEntity);
    //Act
    final result = await uploadPhotoRepository.uploadPhoto(photoFilePath);
    final successResult = result as Success<UploadPhotoResponseEntity>;
    //Assert
    expect(result,isA<Success<UploadPhotoResponseEntity>>());
    verify(mockUploadPhotoDataSource.uploadPhoto(photoFilePath)).called(1);
     expect(successResult.data.message, expectedSuccessUploadPhotoResponseEntity.data.message);

  });
}