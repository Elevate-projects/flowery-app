import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/domain/repositories/cart/cart_repositories/cart_repositories.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_get_logged_user/remote_data_source_get_logged_user.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final RemoteDataSourceGetLoggedUser remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<GetLoggedUserCartEntity>> getLoggedUserCart() async {
    return await remoteDataSource.getLoggedUserCart();
  }
}
