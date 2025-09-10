import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_Item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_items.g.dart';
@JsonSerializable()
class CartItemsModel{
  @JsonKey(name: "product")
  final ProductCardModel? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  CartItemsModel({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return _$CartItemsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartItemsModelToJson(this);
  }
  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product?.toProductCardEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}