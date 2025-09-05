sealed class QuantityIntent {}

class UpdateCartQuantityIntent extends QuantityIntent {
  final String productId;
  final String token;
  final int quantity;

  UpdateCartQuantityIntent({
    required this.productId,
    required this.token,
    required this.quantity,
  });
}
