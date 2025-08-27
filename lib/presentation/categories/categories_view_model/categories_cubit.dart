import 'cubit_intent.dart';
import 'cubit_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesState.initial());

  void onIntent(CategoriesIntent intent) {
    if (intent is CategoriesType) {
      _loadCategories();
    }
  }
  void _loadCategories() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false, success: 'success'));
  }
}
