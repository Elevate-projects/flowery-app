import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_quantity_request/remote_data_source_quantity_request.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:flowery_app/domain/repositories/cart/quantity_repositories/quantity_repositories.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RemoteDataSourceQuantityRepositories)
class RemoteDataSourceQuantityRepositoriesImp extends RemoteDataSourceQuantityRepositories{
  final RemoteDataSourceQuantityRequest _request;
  RemoteDataSourceQuantityRepositoriesImp(this._request);

  @override
  Future<Result<QuantityEntity>> updateCartQuantity(String productId, String token, int quantity) {
    return _request.updateCartQuantity(productId, token, quantity);
  }
}