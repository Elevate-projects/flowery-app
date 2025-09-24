import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';

abstract class GetUserOrderRepositories{
  Future<Result<List<OrderEntity>>> getUserOrder();
}