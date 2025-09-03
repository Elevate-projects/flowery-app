import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/category/category_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class CategoriesState extends Equatable {
  final StateStatus<List<CategoryEntity>> categoriesStatus;
  final StateStatus<List<ProductCardEntity>> productsStatus;
  final List<List<ProductCardEntity>> categoriesProductsList;
  final List<String> selectedCategories;
  const CategoriesState({
    this.categoriesStatus = const StateStatus.initial(),
    this.productsStatus = const StateStatus.initial(),
    this.categoriesProductsList = const [],
    this.selectedCategories = const [],
  });

  CategoriesState copyWith({
    StateStatus<List<CategoryEntity>>? categoriesStatus,
    StateStatus<List<ProductCardEntity>>? productsStatus,
    List<List<ProductCardEntity>>? categoriesProductsList,
    List<String>? selectedCategories,
  }) {
    return CategoriesState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      productsStatus: productsStatus ?? this.productsStatus,
      categoriesProductsList:
          categoriesProductsList ?? this.categoriesProductsList,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [
    categoriesStatus,
    productsStatus,
    categoriesProductsList,
    selectedCategories,
  ];
}
