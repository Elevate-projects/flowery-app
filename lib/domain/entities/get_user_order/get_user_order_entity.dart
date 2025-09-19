import 'package:flowery_app/domain/entities/get_user_order/mata_data_get_user_order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity.dart';
class GetUserOrderEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<OrderEntity>? orders;

  GetUserOrderEntity({
    this.message,
    this.metadata,
    this.orders,
  });
}

