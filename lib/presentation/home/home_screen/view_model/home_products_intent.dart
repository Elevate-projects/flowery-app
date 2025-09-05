sealed class HomeProductsIntent {}
class GetAllProductsIntent extends HomeProductsIntent {}
class RefreshHomeProductsIntent extends HomeProductsIntent {}
class RetryLoadingIntent extends HomeProductsIntent {}