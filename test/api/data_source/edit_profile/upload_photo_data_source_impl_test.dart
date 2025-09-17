import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/edit_profile/upload_photo_data_source_impl.dart';
import 'package:flowery_app/api/responses/edit_profile_response/upload_photo_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('when call uploadPhoto form apiClient and returns Success', () async {
    //Arrange
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final uploadPhotoDataSourceImpl = UploadPhotoDataSourceImpl(mockApiClient);
    final expectedResponse = const UploadPhotoResponse(message: 'success');
    final photoFilePath = File('path/to/photo.jpg');
    final expectedResponseEntity = expectedResponse
        .toUploadPhotoResponseEntity();
    provideDummy<UploadPhotoResponseEntity>(expectedResponseEntity);
    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(
      mockApiClient.uploadProfilePhoto(
        token: anyNamed('token'),
        photo: anyNamed('photo'),
      ),
    ).thenAnswer((_) async => expectedResponse);
    //Act
    final result = await uploadPhotoDataSourceImpl.uploadPhoto(photoFilePath);
    final successResult = result as Success<UploadPhotoResponseEntity>;
    //Assert
    expect(result,isA<Success<UploadPhotoResponseEntity?>>());
    verify(mockApiClient.uploadProfilePhoto(token: anyNamed('token'), photo: anyNamed('photo'))).called(1);
    expect(successResult.data.message, expectedResponseEntity.message);
  });
}
