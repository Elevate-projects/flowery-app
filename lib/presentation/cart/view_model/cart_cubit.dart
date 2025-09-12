import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/use_cases/cart/cart_use_case/cart_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
@injectable
class CartCubit extends Cubit<CartState> {
  final GetLoggedUserCartUseCase _getLoggedUserCartUseCase;

  CartCubit(this._getLoggedUserCartUseCase) : super(const CartState());

  Future<void> doIntent(CartIntent intent) async {
    switch (intent) {
      case LoadCartIntent():
        await _loadCart();
    }
  }
  Future<void> _loadCart() async {
    if (FloweryMethodHelper.currentUserToken == null) {
      emit(state.copyWith(
        cartStatus: StateStatus.failure(
          ResponseException(message: AppText.noToken.tr()),
        ),
      ));
      return;
    }
    emit(state.copyWith(cartStatus: const StateStatus.loading()));
    final result = await _getLoggedUserCartUseCase();
    if (isClosed) return;
    switch (result) {
      case Success():
        emit(state.copyWith(cartStatus: StateStatus.success(result.data)));
      case Failure():
        emit(state.copyWith(
          cartStatus: StateStatus.failure(result.responseException),
        ));
    }
  }
}
