import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartCubit extends Cubit<DeleteCartState> {
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  DeleteCartCubit(this._deleteCartItemUseCase) : super(const DeleteCartState());
  Future<void> doIntent(DeleteCartIntent intent) async {
    switch (intent) {
      case DeleteCartItemIntent(:final productId):
        await _deleteCartItem(productId);
    }
  }

  Future<void> _deleteCartItem(String productId) async {
    if (FloweryMethodHelper.currentUserToken != null) {
      emit(state.copyWith(deleteStatus: const StateStatus.loading()));

      final result = await _deleteCartItemUseCase.deleteCartItem(productId);

      if (isClosed) return;
      switch (result) {
        case Success():
          emit(state.copyWith(deleteStatus: StateStatus.success(result.data)));
        case Failure():
          emit(
            state.copyWith(
              deleteStatus: StateStatus.failure(result.responseException),
            ),
          );
      }
    }
  }
}
