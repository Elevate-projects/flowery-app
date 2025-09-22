import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
class GetUserOrderEntity {
  final String? message;
  final List<OrderEntity>? orders;

  GetUserOrderEntity({
    this.message,
    this.orders,
  });
}

