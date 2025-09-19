import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';

class GetUserOrderState {
  final StateStatus<GetUserOrderEntity> orderStatus;

  const GetUserOrderState({
    this.orderStatus = const StateStatus.initial(),
  });

  GetUserOrderState copyWith({
    StateStatus<GetUserOrderEntity>? orderStatus,
  }) {
    return GetUserOrderState(
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
