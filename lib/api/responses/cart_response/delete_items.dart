import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_items.g.dart';

@JsonSerializable()
class DeleteItems {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  DeleteItems ({
    this.message,
    this.numOfCartItems,
  });

  factory DeleteItems.fromJson(Map<String, dynamic> json) {
    return _$DeleteItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteItemsToJson(this);
  }
  DeleteItemsEntity toEntity() {
    return DeleteItemsEntity(
      message: message,
      numOfCartItems: numOfCartItems,
    );
  }
}



