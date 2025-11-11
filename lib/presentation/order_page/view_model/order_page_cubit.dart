import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/use_cases/get_user_order/get_user_order_usecase.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserOrderCubit extends Cubit<GetUserOrderState> {
  final GetUserUseCase getUserUseCase;

  GetUserOrderCubit(this.getUserUseCase) : super(const GetUserOrderState());

  Future<void> fetchUserOrders() async {
    emit(state.copyWith(orderStatus: const StateStatus.loading()));

    final result = await getUserUseCase.getUserOrder();
    if (isClosed) return;
    switch (result) {
      case Success():
        emit(state.copyWith(orderStatus: StateStatus.success(result.data)));
      case Failure():
        emit(
          state.copyWith(
            orderStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
