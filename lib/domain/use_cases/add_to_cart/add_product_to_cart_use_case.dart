import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/repositories/add_to_cart/add_to_cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  final AddToCartRepository _addToCartRepository;
  const AddProductToCartUseCase(this._addToCartRepository);

  Future<Result<void>> invoke({required AddToCartRequestEntity request}) async {
    return await _addToCartRepository.addProductToCart(request: request);
  }
}
