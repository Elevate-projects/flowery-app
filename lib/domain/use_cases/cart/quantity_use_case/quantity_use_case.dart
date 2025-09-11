import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:flowery_app/domain/repositories/cart/quantity_repositories/quantity_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class QuantityUseCase{
  final RemoveQuantityRepositories _request;
  QuantityUseCase(this._request);
  Future<Result<QuantityEntity>> updateCartQuantity(String productId, int quantity) {
    return _request.updateCartQuantity(productId, quantity);
  }
}