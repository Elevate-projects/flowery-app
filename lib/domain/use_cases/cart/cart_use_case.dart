import 'package:flowery_app/api/client/api_result.dart';

import '../../entities/cart/get_logged_user_cart.dart';
import '../../repositories/cart/cart_repositories.dart';
class GetLoggedUserCartUseCase {
  final CartRepository repository;

  GetLoggedUserCartUseCase(this.repository);

  Future<Result<GetLoggedUserCartEntity>> call(String token) {
    return repository.getLoggedUserCart(token);
  }
}
