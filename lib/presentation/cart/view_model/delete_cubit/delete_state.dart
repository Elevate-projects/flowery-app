import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';

class DeleteCartState {
  final StateStatus<DeleteItemsEntity> deleteStatus;
  const DeleteCartState({
    this.deleteStatus = const StateStatus.initial(),
  });
  DeleteCartState copyWith({
    StateStatus<DeleteItemsEntity>? deleteStatus,
  })
  {
    return DeleteCartState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }
}