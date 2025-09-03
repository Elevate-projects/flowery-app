  import 'package:json_annotation/json_annotation.dart';

  part 'cart_response.g.dart';

  @JsonSerializable()
  class CartResponse {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "numOfCartItems")
    final int? numOfCartItems;
    @JsonKey(name: "cart")
    final Cart? cart;

    CartResponse ({
      this.message,
      this.numOfCartItems,
      this.cart,
    });

    factory CartResponse.fromJson(Map<String, dynamic> json) {
      return _$CartResponseFromJson(json);
    }

    Map<String, dynamic> toJson() {
      return _$CartResponseToJson(this);
    }
  }

  @JsonSerializable()
  class Cart {
    @JsonKey(name: "_id")
    final String? Id;
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
      this.Id,
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
    final String? Id;

    CartItems ({
      this.product,
      this.price,
      this.quantity,
      this.Id,
    });

    factory CartItems.fromJson(Map<String, dynamic> json) {
      return _$CartItemsFromJson(json);
    }

    Map<String, dynamic> toJson() {
      return _$CartItemsToJson(this);
    }
  }

  @JsonSerializable()
  class Product {
    @JsonKey(name: "rateAvg")
    final int? rateAvg;
    @JsonKey(name: "rateCount")
    final int? rateCount;
    @JsonKey(name: "_id")
    final String? Id;
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
    @JsonKey(name: "isSuperAdmin")
    final bool? isSuperAdmin;
    @JsonKey(name: "sold")
    final int? sold;
    @JsonKey(name: "id")
    final String? id;

    Product ({
      this.rateAvg,
      this.rateCount,
      this.Id,
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
      this.isSuperAdmin,
      this.sold,
      this.id,
    });

    factory Product.fromJson(Map<String, dynamic> json) {
      return _$ProductFromJson(json);
    }

    Map<String, dynamic> toJson() {
      return _$ProductToJson(this);
    }
  }