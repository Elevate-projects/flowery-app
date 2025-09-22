import 'package:flowery_app/api/models/get_user_order/get_user_order_model.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_entity/get_user_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_user_order.g.dart';
@JsonSerializable()
class GetUserOrderResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orders")
  final List<GetUsersOrdersModel>? orders;

  GetUserOrderResponse ({
    this.message,
    this.orders,
  });

  factory GetUserOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$GetUserOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetUserOrderResponseToJson(this);
  }
  GetUserOrderEntity toEntity() {
    return GetUserOrderEntity(
      message: message,
      orders: orders?.map((e) => e.toEntity()).toList(),
    );
  }
}


