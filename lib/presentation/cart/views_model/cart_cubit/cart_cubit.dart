import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flowery_app/domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart';
import 'package:flowery_app/domain/use_cases/cart/quantity_use_case/quantity_use_case.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_intent.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetLoggedUserCartUseCase _getLoggedUserCartUseCase;
  final QuantityUseCase _quantityUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  CartCubit(
    this._getLoggedUserCartUseCase,
    this._quantityUseCase,
    this._deleteCartItemUseCase,
  ) : super(const CartState());

  Future<void> doIntent(CartIntent intent) async {
    switch (intent) {
      case LoadCartIntent():
        await _loadCart();
      case UpdateCartQuantityIntent():
        await _updateCartQuantity(intent.productId, intent.quantity);
      case DeleteCartItemIntent():
        await _deleteCartItem(intent.productId);
    }
  }

  Future<void> _loadCart() async {
    emit(state.copyWith(cartStatus: const StateStatus.loading()));
    final result = await _getLoggedUserCartUseCase();
    if (isClosed) return;
    switch (result) {
      case Success():
        emit(state.copyWith(cartStatus: StateStatus.success(result.data)));
      case Failure():
        emit(
          state.copyWith(
            cartStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _updateCartQuantity(String productId, int quantity) async {
    final currentProductQuantity =
        (state.cartStatus.data?.cart?.cartItems
            ?.firstWhere((cartItem) => cartItem.product?.productId == productId)
            .quantity ??
        1);
    final bool isQuantityIncreased = quantity > currentProductQuantity;
    emit(
      state.copyWith(
        quantityStatus: const StateStatus.loading(),
        currentProductId: productId,
        isQuantityIncreased: isQuantityIncreased,
        isQuantityDecreased: !isQuantityIncreased,
      ),
    );
    final result = await _quantityUseCase.updateCartQuantity(
      productId,
      quantity,
    );
    if (isClosed) return;
    switch (result) {
      case Success():
        {
          final currentCartItem = state.cartStatus.data?.cart?.cartItems
              ?.firstWhere(
                (cartItem) => cartItem.product?.productId == productId,
              );
          currentCartItem?.quantity = quantity;
          state.cartStatus.data!.cart!.totalPrice =
              (state.cartStatus.data!.cart!.totalPrice ?? 0) +
              (isQuantityIncreased
                  ? (currentCartItem!.product!.price ?? 0)
                  : -(currentCartItem!.product!.price ?? 0));
          emit(
            state.copyWith(
              quantityStatus: StateStatus.success(result.data),
              currentProductId: "",
              cartStatus: state.cartStatus,
              isQuantityIncreased: false,
              isQuantityDecreased: false,
            ),
          );
        }
      case Failure():
        emit(
          state.copyWith(
            quantityStatus: StateStatus.failure(result.responseException),
            currentProductId: "",
            isQuantityIncreased: false,
            isQuantityDecreased: false,
          ),
        );
    }
  }

  Future<void> _deleteCartItem(String productId) async {
    emit(
      state.copyWith(
        deleteStatus: const StateStatus.loading(),
        currentProductId: productId,
      ),
    );
    final result = await _deleteCartItemUseCase.deleteCartItem(productId);
    if (isClosed) return;
    switch (result) {
      case Success():
        {
          final currentCartItem = state.cartStatus.data?.cart?.cartItems
              ?.firstWhere(
                (cartItem) => cartItem.product?.productId == productId,
              );
          state.cartStatus.data!.cart!.totalPrice =
              (state.cartStatus.data!.cart!.totalPrice ?? 0) -
              (currentCartItem!.product!.price! * currentCartItem.quantity!);

          state.cartStatus.data?.cart?.cartItems?.removeWhere(
            (item) => item.product?.productId == productId,
          );

          emit(
            state.copyWith(
              deleteStatus: StateStatus.success(result.data),
              cartStatus: state.cartStatus,
              currentProductId: "",
            ),
          );
        }
      case Failure():
        emit(
          state.copyWith(
            deleteStatus: StateStatus.failure(result.responseException),
            currentProductId: "",
          ),
        );
    }
  }
}
