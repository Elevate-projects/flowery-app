import 'package:flowery_app/api/responses/get_user_order/orders_items_get_user_order/order_items_get_user_order.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_user_order_model.g.dart';
@JsonSerializable()
class GetUsersOrdersModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<OrderItems>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? V;

  GetUsersOrdersModel ({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.V,
  });

  factory GetUsersOrdersModel.fromJson(Map<String, dynamic> json) {
    return _$GetUsersOrdersModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetUsersOrdersModelToJson(this);
  }
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      user: user,
      orderItems: orderItems?.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
    );
  }
}