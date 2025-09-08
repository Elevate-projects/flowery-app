import 'package:equatable/equatable.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}
class InitialSearchState extends SearchState{

}
class SearchLoadingState extends SearchState{

}
class SearchSuccessState extends SearchState{
    final List<ProductCardEntity> products;
  const SearchSuccessState({required this.products});
  @override
  List<Object?> get props => [products];

}
class SearchFailureState extends SearchState{
  final String error;

  const SearchFailureState({required this.error});

  @override
  List<Object?> get props => [error];

}


