import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/repositories/logout/logout_repository.dart';
import 'package:flowery_app/domain/use_cases/logout/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([LogoutRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockLogoutRepository mockLogoutRepository;
  late final LogoutUseCase logoutUseCase;

  setUpAll(() {
    mockLogoutRepository = MockLogoutRepository();
    logoutUseCase = LogoutUseCase(mockLogoutRepository);
  });
  test(
    'when call logout it should be called successfully from LogoutRepository',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockLogoutRepository.logout(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await logoutUseCase.invoke();
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(mockLogoutRepository.logout()).called(1);
    },
  );
}
