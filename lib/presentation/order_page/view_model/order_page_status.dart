import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';

class GetUserOrderState {
  final StateStatus<List<OrderEntity>> orderStatus;

  const GetUserOrderState({
    this.orderStatus = const StateStatus.initial(),
  });

  GetUserOrderState copyWith({
    StateStatus<List<OrderEntity>>? orderStatus,
  }) {
    return GetUserOrderState(
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
