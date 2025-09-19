import 'package:flowery_app/api/responses/get_user_order/mata_data_get_user_order.dart';
import 'package:flowery_app/api/responses/get_user_order/order_get_user_order.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_user_order.g.dart';
@JsonSerializable()
class GetUserOrder {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "orders")
  final List<Orders>? orders;

  GetUserOrder ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory GetUserOrder.fromJson(Map<String, dynamic> json) {
    return _$GetUserOrderFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetUserOrderToJson(this);
  }
  GetUserOrderEntity toEntity() {
    return GetUserOrderEntity(
      message: message,
      metadata: metadata?.toEntity(),
      orders: orders?.map((e) => e.toEntity()).toList(),
    );
  }
}


