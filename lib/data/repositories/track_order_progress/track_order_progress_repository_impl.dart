import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/track_order_progress/remote_data_source/track_order_progress_remote_data_source.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/repositories/track_order_progress/track_order_progress_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderProgressRepository)
class TrackOrderProgressRepositoryImpl implements TrackOrderProgressRepository {
  final TrackOrderProgressRemoteDataSource _trackOrderProgressRemoteDataSource;
  const TrackOrderProgressRepositoryImpl(
    this._trackOrderProgressRemoteDataSource,
  );

  @override
  Stream<Result<OrderEntity?>> fetchTrackedOrderData({
    required String orderId,
  }) async* {
    yield* _trackOrderProgressRemoteDataSource.fetchTrackedOrderData(
      orderId: orderId,
    );
  }

  @override
  Future<Result<void>> receivedOrder({required String orderId}) async {
    return await _trackOrderProgressRemoteDataSource.receivedOrder(
      orderId: orderId,
    );
  }
}
