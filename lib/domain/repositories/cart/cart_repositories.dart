import 'package:flowery_app/api/client/api_result.dart';

import '../../entities/cart/get_logged_user_cart.dart';

abstract class CartRepository {
  Future<Result<GetLoggedUserCartEntity>> getLoggedUserCart(String token);
}
