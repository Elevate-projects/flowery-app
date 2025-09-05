import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/use_cases/home_products/home_products_use_case.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_intent.dart';
import 'package:injectable/injectable.dart';

part 'home_products_state.dart';

@injectable
class HomeProductsCubit extends Cubit<HomeProductsState> {
  final HomeProductsUseCase _homeProductsUseCase;
  List<ProductsResponseEntity> products = [];
  HomeProductsCubit(this._homeProductsUseCase)
    : super(const HomeProductsState());

  Future<void> doIntent({required HomeProductsIntent intent}) async {
    switch (intent) {
      case GetAllProductsIntent():
        await _getAllProducts();
        break;
      case RefreshHomeProductsIntent():
        // await _refreshHomeProducts();
        break;
      case RetryLoadingIntent():
        // await _retryLoading();
        break;
    }
  }

  Future<void> _getAllProducts() async {
    emit(state.copyWith(homeState: const StateStatus.loading()));
    final homeProducts = await _homeProductsUseCase.invoke();

    switch (homeProducts) {
      case Success<ProductsResponseEntity>():
        {
          emit(
            state.copyWith(homeState: StateStatus.success(homeProducts.data)),
          );
          break;
        }
      case Failure<ProductsResponseEntity>():
        {
          emit(
            state.copyWith(
              homeState: StateStatus.failure(homeProducts.responseException),
            ),
          );
          break;
        }
    }
  }
}