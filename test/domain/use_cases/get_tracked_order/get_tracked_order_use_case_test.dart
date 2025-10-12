import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/entities/user/user_entity.dart';
import 'package:flowery_app/domain/repositories/track_order_progress/track_order_progress_repository.dart';
import 'package:flowery_app/domain/use_cases/get_tracked_order/get_tracked_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tracked_order_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderProgressRepository])
void main() {
  test(
    'when call fetchTrackedOrderData it should be called successfully from TrackOrderProgressRepository and returns the order Data',
    () async {
      // Arrange
      final MockTrackOrderProgressRepository mockTrackOrderProgressRepository =
          MockTrackOrderProgressRepository();
      final GetTrackedOrderUseCase getTrackedOrderUseCase =
          GetTrackedOrderUseCase(mockTrackOrderProgressRepository);
      final String orderId = "12345";
      final expectedResult = OrderEntity(
        id: orderId,
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: const UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );
      final expectedSuccessResult = Success<OrderEntity?>(expectedResult);
      provideDummy<Result<OrderEntity?>>(expectedSuccessResult);

      when(
        mockTrackOrderProgressRepository.fetchTrackedOrderData(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) => Stream.value(expectedSuccessResult));

      // Act
      final result = await getTrackedOrderUseCase
          .invoke(orderId: orderId)
          .first;

      // Assert
      verify(
        mockTrackOrderProgressRepository.fetchTrackedOrderData(
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      expect(result, isA<Success<OrderEntity?>>());
      final successResult = result as Success<OrderEntity?>;
      expect(successResult.data?.id, equals(expectedResult.id));
      expect(successResult.data?.state, equals(expectedResult.state));
      expect(
        successResult.data?.paymentType,
        equals(expectedResult.paymentType),
      );
      expect(successResult.data?.totalPrice, equals(expectedResult.totalPrice));
      expect(
        successResult.data?.user?.firstName,
        equals(expectedResult.user?.firstName),
      );
      expect(
        successResult.data?.user?.lastName,
        equals(expectedResult.user?.lastName),
      );
    },
  );
}
