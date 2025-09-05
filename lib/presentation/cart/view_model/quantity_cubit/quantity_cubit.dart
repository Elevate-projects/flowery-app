import 'package:flowery_app/domain/use_cases/cart/quantity_use_case/quantity_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/api/client/api_result.dart';
@injectable
class QuantityCubit extends Cubit<QuantityState> {
  final QuantityUseCase _quantityUseCase;

  QuantityCubit(this._quantityUseCase) : super(const QuantityState());

  Future<void> doIntent(QuantityIntent intent) async {
    switch (intent) {
      case UpdateCartQuantityIntent(:final productId, :final token, :final quantity):
        emit(state.copyWith(
          quantityStatus: const StateStatus.loading(),
          currentProductId: productId,
        ));

        final result = await _quantityUseCase.updateCartQuantity(productId, token, quantity);

        if (isClosed) return;

        switch (result) {
          case Success():
            emit(state.copyWith(
              quantityStatus: StateStatus.success(result.data),
              currentProductId: null,
            ));
          case Failure():
            emit(state.copyWith(
              quantityStatus: StateStatus.failure(result.responseException),
              currentProductId: null,
            ));
        }
    }
  }
}

