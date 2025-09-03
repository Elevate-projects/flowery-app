import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart.dart';
import '../../../domain/repositories/cart/cart_repositories.dart';
import '../../data_source/cart/remote_data_source_get_logged_user/remote_data_source_get_logged_user.dart';

class CartRepositoryImpl implements CartRepository {
  final RemoteDataSourceGetLoggedUser remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<GetLoggedUserCartEntity>> getLoggedUserCart(String token) async {
    return await remoteDataSource.getLoggedUserCart(token);
  }
}
