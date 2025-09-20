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