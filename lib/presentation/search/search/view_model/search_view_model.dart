import 'package:bloc/bloc.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/use_cases/search/search_use_case.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_intent.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_state.dart';
import 'package:injectable/injectable.dart';
@injectable
class SearchViewModel extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;

  SearchViewModel(this._searchUseCase) :super(InitialSearchState());


  void doIntent(  SearchIntent intent) {
    switch (intent) {
      case OnSearchClick():
        _search(intent.productId);
    }
  }

  Future<void> _search(String productId) async {
    emit(SearchLoadingState());
    final res = await _searchUseCase.call(productId);
    switch (res) {
      case Success<ProductsResponseEntity>():
        emit(SearchSuccessState(products: res.data.products??[]));
      case Failure<ProductsResponseEntity>():
        emit(SearchFailureState(error: res.responseException.message));

    }
  }
  }
