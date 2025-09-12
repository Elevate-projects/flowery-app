import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';

class QuantityState {
  final StateStatus<QuantityEntity> quantityStatus;
  final String? currentProductId;

  const QuantityState({
    this.quantityStatus = const StateStatus.initial(),
    this.currentProductId,
  });

  QuantityState copyWith({
    StateStatus<QuantityEntity>? quantityStatus,
    String? currentProductId,
  }) {
    return QuantityState(
      quantityStatus: quantityStatus ?? this.quantityStatus,
      currentProductId: currentProductId ?? this.currentProductId,
    );
  }

  List<Object?> get props => [quantityStatus, currentProductId];
}
