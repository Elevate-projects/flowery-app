import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/get_user_order/remote_data_source/get_user_order_data_source.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flowery_app/domain/repositories/get_user_order/get_user_order_repositories.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GetUserOrderRepositories)
class GetUserOrderRepositoriesImp implements GetUserOrderRepositories{
  final GetUserOrderDataSource dataSource;
  GetUserOrderRepositoriesImp(this.dataSource);
  @override
  Future<Result<GetUserOrderEntity>> getUserOrder() {
    return dataSource.getUserOrder();
  }
}