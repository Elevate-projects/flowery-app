sealed class SearchIntent{}
class OnSearchClick extends SearchIntent{
  String search;
  OnSearchClick({required this.search});
}