import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/repositories/track_order_progress/track_order_progress_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetTrackedOrderUseCase {
  final TrackOrderProgressRepository _trackOrderProgressRepository;
  const GetTrackedOrderUseCase(this._trackOrderProgressRepository);

  Stream<Result<OrderEntity?>> invoke({required String orderId}) async* {
    yield* _trackOrderProgressRepository.fetchTrackedOrderData(
      orderId: orderId,
    );
  }
}
