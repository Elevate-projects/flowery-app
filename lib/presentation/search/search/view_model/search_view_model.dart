import 'dart:async';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/domain/entities/search/response/search_response_entity.dart';
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
    final res = await _searchUseCase.call(search: search);
    switch (res) {
      case Success<SearchResponseEntity>():
        if (res.data.products.isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(
            SearchSuccessState(
              products: res.data.products.map((p) => p.toCardEntity()).toList(),
            ),
          );
        }
      case Failure<SearchResponseEntity>():
        emit(SearchFailureState(error: res.responseException.message));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
