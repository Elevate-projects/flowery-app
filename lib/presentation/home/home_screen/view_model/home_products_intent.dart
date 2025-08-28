sealed class HomeProductsIntent {}
class GetAllProductsIntent extends HomeProductsIntent {}
class RefreshHomeProductsIntent extends HomeProductsIntent {}
class RetryLoadingIntent extends HomeProductsIntent {}
class NavigateToProductDetailsIntent extends HomeProductsIntent{}
class CategoriesViewAll extends HomeProductsIntent {}
class BestSellersViewAll extends HomeProductsIntent {}
class OccasionsViewAll extends HomeProductsIntent {}