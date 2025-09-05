import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_delete_item/remote_data_source_delete_item.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/repositories/cart/delete_item_repositories/delete_item_repositories.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RemoteDataSourceDeleteItemRepositories)
class RemoteDataSourceDeleteItemRepositoriesImp implements RemoteDataSourceDeleteItemRepositories{
  RemoteDataSourceDeleteItem _sourceDeleteItem;
  RemoteDataSourceDeleteItemRepositoriesImp(this._sourceDeleteItem);
  @override
  Future<Result<DeleteItemsEntity>> deleteCartItem(String productId, String token) {
    return _sourceDeleteItem.deleteCartItem(productId, token);
  }
}