class CashPaymentResponseEntity {
  final String? message;
  final OrderEntity? order;

  CashPaymentResponseEntity({
    this.message,
    this.order,
  });
}

class OrderEntity {
  final String? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;

  OrderEntity({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });
}

class OrderItemEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemEntity({
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
  final int? sold;
  final bool? isSuperAdmin;

  ProductEntity({
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
    this.sold,
    this.isSuperAdmin,
  });
}
