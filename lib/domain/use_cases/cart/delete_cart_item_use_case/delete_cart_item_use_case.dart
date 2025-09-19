import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/repositories/cart/delete_item_repositories/delete_item_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartItemUseCase {
  final DeleteItemRepositories _repositories;
  DeleteCartItemUseCase(this._repositories);
  Future<Result<DeleteItemsEntity>> deleteCartItem(String productId) async {
    return await _repositories.deleteCartItem(productId);
  }
}
