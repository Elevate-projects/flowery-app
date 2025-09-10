import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
class CartState extends Equatable {
  final StateStatus<GetLoggedUserCartEntity> cartStatus;

  const CartState({
    this.cartStatus = const StateStatus.initial(),

  });
  CartState copyWith({
    StateStatus<GetLoggedUserCartEntity>? cartStatus,
  })
  {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
    );
  }

  @override
  List<Object?> get props => [cartStatus];
}
