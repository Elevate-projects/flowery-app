import '../../../../api/client/api_result.dart';
import '../../../../domain/entities/cart/get_logged_user_cart.dart';

abstract class RemoteDataSourceGetLoggedUser{
  Future<Result<GetLoggedUserCartEntity>> getLoggedUserCart(
      String token,
      );
}