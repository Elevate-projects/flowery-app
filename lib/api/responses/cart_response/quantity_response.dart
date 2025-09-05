import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quantity_response.g.dart';

@JsonSerializable()
class QuantityResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  QuantityResponse ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory QuantityResponse.fromJson(Map<String, dynamic> json) {
    return _$QuantityResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuantityResponseToJson(this);
  }
  QuantityEntity toQuantityEntity(){
    return QuantityEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toCartEntity(),
    );
  }
}

@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<CartItems>? cartItems;
  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;

  Cart ({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return _$CartFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartToJson(this);
  }
  CartEntity toCartEntity(){
    return CartEntity(
      id: id,
      user: user,
      cartItems: cartItems?.map((e) => e.toCartItemsEntity()).toList(),
      appliedCoupons: appliedCoupons,
      totalPrice: totalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: V,
    );
  }
}

@JsonSerializable()
class CartItems {
  @JsonKey(name: "product")
  final Product? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  CartItems ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return _$CartItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartItemsToJson(this);
  }
  CartItemEntity toCartItemsEntity(){
    return CartItemEntity(
      product: product?.toProductEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}

@JsonSerializable()
class Product {
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;

  Product ({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.sold,
    this.isSuperAdmin,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
  ProductEntity toProductEntity(){
    return ProductEntity(
      rateAvg: rateAvg,
      rateCount: rateCount,
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: V,
      sold: sold,
      isSuperAdmin: isSuperAdmin,
    );
  }
}


