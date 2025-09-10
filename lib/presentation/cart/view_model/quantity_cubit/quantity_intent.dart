sealed class QuantityIntent {}

class UpdateCartQuantityIntent extends QuantityIntent {
  final String productId;
  final int quantity;

  UpdateCartQuantityIntent({
    required this.productId,
    required this.quantity,
  });
}
