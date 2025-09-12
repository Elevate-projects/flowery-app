import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/logout/remote_data_source/logout_remote_data_source.dart';
import 'package:flowery_app/data/repositories/logout/logout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_repository_impl_test.mocks.dart';

@GenerateMocks([LogoutRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockLogoutRemoteDataSource mockLogoutRemoteDataSource;
  late final LogoutRepositoryImpl logoutRepositoryImpl;

  setUpAll(() {
    mockLogoutRemoteDataSource = MockLogoutRemoteDataSource();
    logoutRepositoryImpl = LogoutRepositoryImpl(mockLogoutRemoteDataSource);
  });
  test(
    'when call logout it should be called successfully from LogoutRemoteDataSource',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockLogoutRemoteDataSource.logout(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await logoutRepositoryImpl.logout();
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(mockLogoutRemoteDataSource.logout()).called(1);
    },
  );
}
