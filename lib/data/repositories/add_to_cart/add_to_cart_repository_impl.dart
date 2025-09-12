import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/repositories/add_to_cart/add_to_cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddToCartRepository)
class AddToCartRepositoryImpl implements AddToCartRepository {
  final AddToCartRemoteDataSource _addToCartRemoteDataSource;
  @factoryMethod
  const AddToCartRepositoryImpl(this._addToCartRemoteDataSource);

  @override
  Future<Result<void>> addProductToCart({
    required AddToCartRequestEntity request,
  }) async {
    return await _addToCartRemoteDataSource.addProductToCart(request: request);
  }
}
