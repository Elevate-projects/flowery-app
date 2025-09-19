import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';

class CartState extends Equatable {
  final StateStatus<GetLoggedUserCartEntity> cartStatus;
  final StateStatus<QuantityEntity> quantityStatus;
  final StateStatus<DeleteItemsEntity> deleteStatus;
  final String currentProductId;
  final bool isQuantityIncreased;
  final bool isQuantityDecreased;

  const CartState({
    this.cartStatus = const StateStatus.initial(),
    this.quantityStatus = const StateStatus.initial(),
    this.deleteStatus = const StateStatus.initial(),
    this.currentProductId = "",
    this.isQuantityDecreased = false,
    this.isQuantityIncreased = false,
  });
  CartState copyWith({
    StateStatus<GetLoggedUserCartEntity>? cartStatus,
    StateStatus<QuantityEntity>? quantityStatus,
    StateStatus<DeleteItemsEntity>? deleteStatus,
    String? currentProductId,
    bool? isQuantityIncreased,
    bool? isQuantityDecreased,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      quantityStatus: quantityStatus ?? this.quantityStatus,
      currentProductId: currentProductId ?? this.currentProductId,
      isQuantityDecreased: isQuantityDecreased ?? this.isQuantityDecreased,
      isQuantityIncreased: isQuantityIncreased ?? this.isQuantityIncreased,
    );
  }

  @override
  List<Object?> get props => [
    cartStatus,
    quantityStatus,
    deleteStatus,
    currentProductId,
    isQuantityDecreased,
    isQuantityIncreased,
  ];
}
