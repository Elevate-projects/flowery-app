sealed class SearchIntent{}
class OnSearchClick extends SearchIntent{
  String productId;
  OnSearchClick({required this.productId});
}