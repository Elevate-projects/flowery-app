import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/track_order_progress/remote_data_source/track_order_progress_remote_data_source.dart';
import 'package:flowery_app/data/repositories/track_order_progress/track_order_progress_repository_impl.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_progress_repository_impl_test.mocks.dart';

@GenerateMocks([TrackOrderProgressRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockTrackOrderProgressRemoteDataSource
  mockTrackOrderProgressRemoteDataSource;
  late final TrackOrderProgressRepositoryImpl trackOrderProgressRepositoryImpl;
  setUpAll(() {
    mockTrackOrderProgressRemoteDataSource =
        MockTrackOrderProgressRemoteDataSource();
    trackOrderProgressRepositoryImpl = TrackOrderProgressRepositoryImpl(
      mockTrackOrderProgressRemoteDataSource,
    );
  });

  test(
    'when call fetchTrackedOrderData it should be called successfully from OrderDetailsRemoteDataSource and returns the order Data',
    () async {
      // Arrange
      final String orderId = "12345";
      final expectedResult = OrderEntity(
        id: orderId,
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: const UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );
      final expectedSuccessResult = Success(expectedResult);
      provideDummy<Result<OrderEntity>>(expectedSuccessResult);

      when(
        mockTrackOrderProgressRemoteDataSource.fetchTrackedOrderData(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) => Stream.value(expectedSuccessResult));

      // Act
      final result = await trackOrderProgressRepositoryImpl
          .fetchTrackedOrderData(orderId: orderId)
          .first;

      // Assert
      verify(
        mockTrackOrderProgressRemoteDataSource.fetchTrackedOrderData(
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

  test(
    'when call receivedOrder it should be called successfully from TrackOrderProgressRemoteDataSource',
    () async {
      // Arrange
      final String orderId = "12345";
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockTrackOrderProgressRemoteDataSource.receivedOrder(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await trackOrderProgressRepositoryImpl.receivedOrder(
        orderId: orderId,
      );

      // Assert
      verify(
        mockTrackOrderProgressRemoteDataSource.receivedOrder(
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
