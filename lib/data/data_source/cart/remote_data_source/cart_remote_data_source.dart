import '../../../../api/client/api_result.dart';
import '../../../../api/requests/cart_request/cart_request.dart';
import '../../../../domain/entities/cart/cart_entities.dart';
abstract class CartRemoteDataSource {
  Future<Result<ProductEntity>> cartPage({
    required Cart_request request,
    required String token,
  });
}
