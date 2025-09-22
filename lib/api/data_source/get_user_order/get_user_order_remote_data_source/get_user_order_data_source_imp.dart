import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/get_user_order/remote_data_source/get_user_order_data_source.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GetUserOrderDataSource)
class GetUserOrderDataSourceImp implements GetUserOrderDataSource {
  final ApiClient apiClient;
  GetUserOrderDataSourceImp(this.apiClient);

  @override
  Future<Result<List<OrderEntity>>>getUserOrder() {
    return executeApi(() async {
      final result = await apiClient.getUserOrder(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
      return result.toEntity().orders ?? [];
    });
  }
}
