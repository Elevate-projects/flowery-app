import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';

abstract class AddToCartRepository {
  Future<Result<void>> addProductToCart({
    required AddToCartRequestEntity request,
  });
}
