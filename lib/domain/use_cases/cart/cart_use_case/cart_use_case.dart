import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/repositories/cart/cart_repositories/cart_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetLoggedUserCartUseCase {
  final CartRepository repository;

  GetLoggedUserCartUseCase(this.repository);

  Future<Result<GetLoggedUserCartEntity>> call(String token) {
    return repository.getLoggedUserCart(token);
  }
}
