sealed class CategoriesIntent {}

class CategoriesInitializationIntent extends CategoriesIntent {}

class ChangeCategoryFilterIntent extends CategoriesIntent {
  ChangeCategoryFilterIntent({required this.selectedFilter});
  final String selectedFilter;
}
