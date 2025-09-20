import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_get_user_order.g.dart';

@JsonSerializable()
class OrderItems {
  @JsonKey(name: "product")
  final ProductCardModel? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItems ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product?.toProductCardEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
