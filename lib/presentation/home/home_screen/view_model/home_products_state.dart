part of 'home_products_cubit.dart';

class HomeProductsState extends Equatable {
  final StateStatus<ProductsResponseEntity> homeState;
  const HomeProductsState({this.homeState = const StateStatus.initial()});

  HomeProductsState copyWith({StateStatus<ProductsResponseEntity>? homeState}) {
    return HomeProductsState(homeState: homeState ?? this.homeState);
  }

  @override
  List<Object?> get props => [homeState];
}

final class CategoriesViewAllState extends HomeProductsState {
  @override
  List<Object?> get props => [];
}

final class BestSellersViewAllState extends HomeProductsState {
  @override
  List<Object?> get props => [];
}

final class OccasionsViewAllState extends HomeProductsState {
  @override
  List<Object?> get props => [];
}
