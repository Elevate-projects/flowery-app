class AddProductCartEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const AddProductCartEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
}

class CartEntity {
  final String? id;
  final String? user;
  final List<CartItemEntity>? cartItems;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  const CartEntity({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}

class CartItemEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const CartItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}

class ProductEntity {
  final int? rateAvg;
  final int? rateCount;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isSuperAdmin;
  final int? sold;

  const ProductEntity({
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
    this.v,
    this.isSuperAdmin,
    this.sold,
  });
}
