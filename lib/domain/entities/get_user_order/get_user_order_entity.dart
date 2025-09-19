class GetUserOrderEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<OrderEntity>? orders;

  GetUserOrderEntity({
    this.message,
    this.metadata,
    this.orders,
  });
}

class MetadataEntity {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  MetadataEntity({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });
}

class OrderEntity {
  final String? id;
  final String? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;

  OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
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
  final String? id;
  final String? title;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;

  ProductEntity({
    this.id,
    this.title,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
  });
}
