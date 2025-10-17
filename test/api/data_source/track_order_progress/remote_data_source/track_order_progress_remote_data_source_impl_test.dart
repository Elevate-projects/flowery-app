import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/track_order_progress/remote_data_source/track_order_progress_remote_data_source_impl.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/core/constants/app_collections.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_progress_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final FakeFirebaseFirestore fakeFirestore;
  late final MockConnectivity mockedConnectivity;
  late final TrackOrderProgressRemoteDataSourceImpl
  trackOrderProgressRemoteDataSourceImpl;
  setUpAll(() async {
    fakeFirestore = FakeFirebaseFirestore();
    trackOrderProgressRemoteDataSourceImpl =
        TrackOrderProgressRemoteDataSourceImpl(fakeFirestore);
    mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  test(
    'when call fetchTrackedOrderData it should be called successfully from FirebaseFirestore and returns the selected order data',
    () async {
      // Arrange
      final orderId = "12345";

      final orderJson = {
        "_id": orderId,
        "state": "inProgress",
        "paymentType": "cash",
        "totalPrice": 3560,
        "user": {"firstName": "Ahmed", "lastName": "Tarek"},
      };

      await fakeFirestore
          .collection(AppCollections.orders)
          .doc(orderId)
          .set(orderJson);

      final expectedResult = const OrderEntity(
        id: "12345",
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );

      // Act
      final result = await trackOrderProgressRemoteDataSourceImpl
          .fetchTrackedOrderData(orderId: orderId)
          .first;

      // Assert
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
    'when call receivedOrder it should be called successfully from FirebaseFirestore and update firestore state value',
    () async {
      // Arrange
      final orderId = "12345";
      provideDummy<Result<void>>(Success(null));

      await fakeFirestore.collection(AppCollections.orders).doc(orderId).set({
        "state": "inProgress",
      });

      // Act
      final result = await trackOrderProgressRemoteDataSourceImpl.receivedOrder(
        orderId: orderId,
      );

      // Assert
      expect(result, isA<Success<void>>());

      final updatedDoc = await fakeFirestore
          .collection(AppCollections.orders)
          .doc(orderId)
          .get();

      expect(updatedDoc.data()?['state'], equals(ConstKeys.completed));
    },
  );
}
