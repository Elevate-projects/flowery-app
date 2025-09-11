import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/use_cases/add_to_cart/add_product_to_cart_use_case.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_intent.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartCubit extends Cubit<AddProductToCartState> {
  final AddProductToCartUseCase _addProductToCartUseCase;
  AddProductToCartCubit(this._addProductToCartUseCase)
    : super(const AddProductToCartState());

  Future<void> doIntent({required AddProductToCartIntent intent}) async {
    switch (intent) {
      case AddToCartIntent():
        await _addProductToCart(request: intent.request);
      case ChangeSelectedProductId():
        _changeSelectedProductId(productId: intent.productId);
    }
  }

  Future<void> _addProductToCart({
    required AddToCartRequestEntity request,
  }) async {
    emit(state.copyWith(addToCartStatus: const StateStatus.loading()));
    final result = await _addProductToCartUseCase.invoke(request: request);
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(state.copyWith(addToCartStatus: const StateStatus.success(null)));
      case Failure<void>():
        emit(
          state.copyWith(
            addToCartStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _changeSelectedProductId({required String productId}) {
    emit(state.copyWith(currentProductId: productId));
  }
}
