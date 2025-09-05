sealed class DeleteCartIntent {}

class DeleteCartItemIntent extends DeleteCartIntent {
  final String productId;
  final String token;

  DeleteCartItemIntent({required this.productId, required this.token});
}