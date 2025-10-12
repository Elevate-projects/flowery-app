import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/repositories/track_order_progress/track_order_progress_repository.dart';
import 'package:flowery_app/domain/use_cases/order_received/order_received_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_received_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderProgressRepository])
void main() {
  test(
    'when call receivedOrder it should be called successfully from TrackOrderProgressRepository',
    () async {
      // Arrange
      final MockTrackOrderProgressRepository mockTrackOrderProgressRepository =
          MockTrackOrderProgressRepository();
      final OrderReceivedUseCase orderReceivedUseCase = OrderReceivedUseCase(
        mockTrackOrderProgressRepository,
      );
      final String orderId = "1234";

      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockTrackOrderProgressRepository.receivedOrder(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await orderReceivedUseCase.invoke(orderId: orderId);

      // Assert
      verify(
        mockTrackOrderProgressRepository.receivedOrder(
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
