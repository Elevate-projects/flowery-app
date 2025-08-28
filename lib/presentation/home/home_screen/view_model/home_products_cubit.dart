import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/use_cases/home_products/home_products_use_case.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_intent.dart';

part 'home_products_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  final HomeProductsUseCase _homeProductsUseCase;
  List<ProductsResponseEntity> products = [];
  HomeProductsCubit(this._homeProductsUseCase) : super(const HomeProductsState());


  Future<void> doIntent(HomeProductsIntent intent) async {
    if (intent is GetAllProductsIntent) {
     await _getAllProducts();
    } else if (intent is RefreshHomeProductsIntent) {
      // _refreshHomeProducts();
    } else if (intent is RetryLoadingIntent) {
       //_retryLoading();
    } else if (intent is NavigateToProductDetailsIntent) {
      // _navigateToProductDetails();
    } else if (intent is CategoriesViewAll) {
      _viewAllCategories();
    } else if (intent is BestSellersViewAll) {
      _viewAllBestSellers();
    } else if (intent is OccasionsViewAll) {
      _viewAllOccasions();
    }
  }




Future<void> _getAllProducts() async {
  emit(state.copyWith(homeState: const StateStatus.loading()));
  final homeProducts = await _homeProductsUseCase.invoke();

  switch(homeProducts){
    case Success<ProductsResponseEntity?>():{
      products = homeProducts as List<ProductsResponseEntity>;
       emit(state.copyWith(homeState: StateStatus.success(homeProducts)));
    }
    break;
    case Failure<ProductsResponseEntity>():
      emit(state.copyWith(homeState: StateStatus.failure(homeProducts.responseException)));
      break;
  }
}

  void _viewAllCategories() async {
    emit(CategoriesViewAllState());
  }

  void _viewAllBestSellers() async {
    emit(BestSellersViewAllState());
  }

  void _viewAllOccasions() async {
    emit(OccasionsViewAllState());
  }
}