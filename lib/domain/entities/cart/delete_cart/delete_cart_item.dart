class DeleteItemsEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const DeleteItemsEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
}

class CartEntity {
  final String? id;
  final String? user;
  final List<dynamic>? cartItems;
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
