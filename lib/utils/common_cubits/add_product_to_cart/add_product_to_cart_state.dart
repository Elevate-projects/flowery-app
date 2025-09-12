import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class AddProductToCartState extends Equatable {
  final StateStatus<String> addToCartStatus;
  final String currentProductId;
  const AddProductToCartState({
    this.addToCartStatus = const StateStatus.initial(),
    this.currentProductId = "",
  });

  AddProductToCartState copyWith({
    StateStatus<String>? addToCartStatus,
    String? currentProductId,
  }) {
    return AddProductToCartState(
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      currentProductId: currentProductId ?? this.currentProductId,
    );
  }

  @override
  List<Object?> get props => [addToCartStatus, currentProductId];
}
