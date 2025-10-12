import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/repositories/track_order_progress/track_order_progress_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderReceivedUseCase {
  final TrackOrderProgressRepository _trackOrderProgressRepository;
  const OrderReceivedUseCase(this._trackOrderProgressRepository);

  Future<Result<void>> invoke({required String orderId}) async {
    return await _trackOrderProgressRepository.receivedOrder(orderId: orderId);
  }
}
