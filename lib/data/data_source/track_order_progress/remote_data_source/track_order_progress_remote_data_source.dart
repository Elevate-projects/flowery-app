import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';

abstract interface class TrackOrderProgressRemoteDataSource {
  Stream<Result<OrderEntity?>> fetchTrackedOrderData({required String orderId});
  Future<Result<void>> receivedOrder({required String orderId});
}
