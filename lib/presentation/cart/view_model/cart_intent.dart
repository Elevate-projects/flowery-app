sealed class CartIntent {}

class LoadCartIntent extends CartIntent {
  final String token;
  LoadCartIntent(this.token);
}
