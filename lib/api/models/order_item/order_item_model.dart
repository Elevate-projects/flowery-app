import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/domain/entities/order_item/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
final class OrderItemModel {
  @JsonKey(name: "product")
  final ProductCardModel? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItemModel({this.product, this.price, this.quantity, this.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return _$OrderItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemModelToJson(this);
  }

  OrderItemEntity toOrderItemEntity() {
    return OrderItemEntity(
      product: product?.toProductCardEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
