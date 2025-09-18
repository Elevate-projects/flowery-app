sealed class CartIntent {}

class LoadCartIntent extends CartIntent {}

class UpdateCartQuantityIntent extends CartIntent {
  final String productId;
  final int quantity;
  UpdateCartQuantityIntent({required this.productId, required this.quantity});
}

class DeleteCartItemIntent extends CartIntent {
  final String productId;
  DeleteCartItemIntent({required this.productId});
}
