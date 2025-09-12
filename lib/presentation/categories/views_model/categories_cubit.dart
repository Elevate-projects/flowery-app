import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_categories_use_case.dart';
import 'package:flowery_app/domain/use_cases/categories/get_all_products_use_case.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_intent.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;
  final List<String> filters = const [
    AppText.lowestPrice,
    AppText.highestPrice,
    AppText.newProducts,
    AppText.old,
    AppText.discount,
  ];
  CategoriesCubit(this._getAllCategoriesUseCase, this._getAllProductsUseCase)
    : super(const CategoriesState());

  Future<void> doIntent({required CategoriesIntent intent}) async {
    switch (intent) {
      case CategoriesInitializationIntent():
        await _onInit();
      case ChangeCategoryFilterIntent():
        _changeFilter(selectedFilter: intent.selectedFilter);
    }
  }

  Future<void> _onInit() async {
    await _getAllCategories();
    if (isClosed) return;
    await _getAllProducts();
    if (state.categoriesStatus.isSuccess && state.productsStatus.isSuccess) {
      _getCategoryProducts();
    }
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(categoriesStatus: const StateStatus.loading()));
    final result = await _getAllCategoriesUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<CategoryEntity>?>():
        emit(
          state.copyWith(
            categoriesStatus: StateStatus.success(result.data ?? []),
          ),
        );
      case Failure<List<CategoryEntity>?>():
        emit(
          state.copyWith(
            categoriesStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _getAllProducts() async {
    emit(state.copyWith(productsStatus: const StateStatus.loading()));
    final result = await _getAllProductsUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<ProductCardEntity>?>():
        emit(
          state.copyWith(
            productsStatus: StateStatus.success(result.data ?? []),
          ),
        );
      case Failure<List<ProductCardEntity>?>():
        emit(
          state.copyWith(
            productsStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  void _getCategoryProducts() {
    List<ProductCardEntity> categoryProducts;
    final List<List<ProductCardEntity>> listOfCategoriesProducts = [];
    final List<String> selectedCategoriesList = [];
    if (state.categoriesStatus.data != null) {
      for (int i = 0; i < state.categoriesStatus.data!.length; i++) {
        categoryProducts =
            state.productsStatus.data
                ?.where(
                  (product) =>
                      product.categoryId == state.categoriesStatus.data?[i].id,
                )
                .toList() ??
            [];
        if (categoryProducts.isNotEmpty) {
          selectedCategoriesList.add(state.categoriesStatus.data![i].name!);
          listOfCategoriesProducts.add(categoryProducts);
        }
      }
    }
    selectedCategoriesList.insert(0, "all");
    listOfCategoriesProducts.insert(0, state.productsStatus.data ?? []);
    emit(
      state.copyWith(
        categoriesProductsList: listOfCategoriesProducts,
        selectedCategories: selectedCategoriesList,
      ),
    );
    _sortProductsToHighestPrice();
    emit(state.copyWith(categoriesProductsList: state.categoriesProductsList));
  }

  void _changeFilter({required String selectedFilter}) {
    if (selectedFilter == filters[0]) {
      _sortProductsToLowestPrice();
    } else if (selectedFilter == filters[1]) {
      _sortProductsToHighestPrice();
    } else if (selectedFilter == filters[2]) {
      _sortProductsToNewest();
    } else if (selectedFilter == filters[3]) {
      _sortProductsToOldest();
    } else {
      _sortProductsToDiscount();
    }
    emit(
      state.copyWith(
        categoriesProductsList: state.categoriesProductsList,
        selectedFilter: selectedFilter,
      ),
    );
  }

  void _sortProductsToLowestPrice() {
    for (int i = 0; i < state.categoriesProductsList.length; i++) {
      for (int j = 0; j < state.categoriesProductsList[i].length; j++) {
        state.categoriesProductsList[i].sort(
          (a, b) => a.priceAfterDiscount!.compareTo(b.priceAfterDiscount!),
        );
      }
    }
  }

  void _sortProductsToHighestPrice() {
    for (int i = 0; i < state.categoriesProductsList.length; i++) {
      for (int j = 0; j < state.categoriesProductsList[i].length; j++) {
        state.categoriesProductsList[i].sort(
          (a, b) => b.priceAfterDiscount!.compareTo(a.priceAfterDiscount!),
        );
      }
    }
  }

  void _sortProductsToNewest() {
    for (int i = 0; i < state.categoriesProductsList.length; i++) {
      for (int j = 0; j < state.categoriesProductsList[i].length; j++) {
        state.categoriesProductsList[i].sort(
          (a, b) => DateTime.parse(
            b.createdAt!,
          ).compareTo(DateTime.parse(a.createdAt!)),
        );
      }
    }
  }

  void _sortProductsToOldest() {
    for (int i = 0; i < state.categoriesProductsList.length; i++) {
      for (int j = 0; j < state.categoriesProductsList[i].length; j++) {
        state.categoriesProductsList[i].sort(
          (a, b) => DateTime.parse(
            a.createdAt!,
          ).compareTo(DateTime.parse(b.createdAt!)),
        );
      }
    }
  }

  void _sortProductsToDiscount() {
    for (int i = 0; i < state.categoriesProductsList.length; i++) {
      for (int j = 0; j < state.categoriesProductsList[i].length; j++) {
        state.categoriesProductsList[i].sort(
          (a, b) => int.parse(
            b.discountPercentage!.replaceAll('%', ''),
          ).compareTo(int.parse(a.discountPercentage!.replaceAll('%', ''))),
        );
      }
    }
  }
}
