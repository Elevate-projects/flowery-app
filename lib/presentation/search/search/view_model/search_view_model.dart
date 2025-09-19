import 'dart:async';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/search/search_use_case.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_intent.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchViewModel extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;
  Timer? _debounce;

  SearchViewModel(this._searchUseCase) : super(InitialSearchState());

  void doIntent(SearchIntent intent) {
    switch (intent) {
      case OnSearchClick():
        final query = intent.search.trim();
        if (query.isEmpty) {
          _debounce?.cancel();
          emit(InitialSearchState());
          return;
        }
        _debounce?.cancel();
        _debounce = Timer(const Duration(seconds: 1), () {
          _search(query);
        });
    }
  }

  Future<void> _search(String search) async {
    emit(SearchLoadingState());
    final result = await _searchUseCase.invoke(search: search);
    switch (result) {
      case Success<List<ProductCardEntity>>():
        if (result.data.isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchSuccessState(products: result.data));
        }
      case Failure<List<ProductCardEntity>>():
        emit(SearchFailureState(error: result.responseException.message));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
