sealed class DeleteCartIntent {}

class DeleteCartItemIntent extends DeleteCartIntent {
  final String productId;
  DeleteCartItemIntent({required this.productId});
}