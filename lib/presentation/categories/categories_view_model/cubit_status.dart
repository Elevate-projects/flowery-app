class CategoriesState {
  final String success;
  final String failure;
  final bool isLoading;
  final List<Category> categories;

  CategoriesState({
    required this.categories,
    required this.success,
    required this.failure,
    required this.isLoading,
  });

  factory CategoriesState.initial() {
    return CategoriesState(
      categories: FakeCategories.categories,
      success: '',
      failure: '',
      isLoading: true,
    );
  }

  CategoriesState copyWith({
    List<Category>? categories,
    String? success,
    String? failure,
    bool? isLoading,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      success: success ?? this.success,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
class Category {
  final String name;
  final String imageUrl;
  final String description;

  Category({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class FakeCategories {
  static List<Category> categories = [
    Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "All",
      imageUrl: "https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg",
    ),
    Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "Plants",
      imageUrl: "https://via.placeholder.com/150/00FF00",
    ),
    Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "Flowers",
      imageUrl: "https://via.placeholder.com/150/FF69B4",
    ),
    Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "Trees",
      imageUrl: "https://via.placeholder.com/150/8B4513",
    ),
    Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "Birds",
      imageUrl: "https://via.placeholder.com/150/1E90FF",
    ),  Category(
      description: "All categories, wfjwefipj43t5454ytgty",
      name: "dogs",
      imageUrl: "https://via.placeholder.com/150/1E90FF",
    ),
  ];
}
