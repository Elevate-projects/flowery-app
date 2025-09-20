import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_items.g.dart';

@JsonSerializable()
class DeleteItem {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  DeleteItem ({
    this.message,
    this.numOfCartItems,
  });

  factory DeleteItem.fromJson(Map<String, dynamic> json) {
    return _$DeleteItemFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteItemToJson(this);
  }
  DeleteItemsEntity toEntity() {
    return DeleteItemsEntity(
      message: message,
      numOfCartItems: numOfCartItems,
    );
  }
}



