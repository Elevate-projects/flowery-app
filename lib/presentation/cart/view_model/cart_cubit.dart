import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetLoggedUserCartUseCase _getLoggedUserCartUseCase;

  CartCubit(this._getLoggedUserCartUseCase) : super(const CartState());

  Future<void> doIntent(CartIntent intent) async {
    switch (intent) {
      case LoadCartIntent(:final token):
        await _loadCart(token);
    }
  }
  Future<void> _loadCart(String token) async {
    emit(state.copyWith(cartStatus: const StateStatus.loading()));
    final result = await _getLoggedUserCartUseCase(token);
    if (isClosed) return;

    switch (result) {
      case Success():
        emit(
          state.copyWith(cartStatus: StateStatus.success(result.data)),
        );
      case Failure():
        emit(
          state.copyWith(cartStatus: StateStatus.failure(result.responseException)),
        );
    }
  }
}
