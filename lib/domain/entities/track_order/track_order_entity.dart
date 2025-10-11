import 'package:equatable/equatable.dart';

/// OrderEntity
final class OrderEntity extends Equatable {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? orderNumber;
  final StoreEntity? store;

  const OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.orderNumber,
    this.store,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    shippingAddress,
    paymentType,
    isPaid,
    isDelivered,
    state,
    orderNumber,
    store,
  ];
}

/// UserEntity
final class UserEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? gender;
  final String? photo;

  const UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.photo,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phone,
    gender,
    photo,
  ];
}

/// OrderItemEntity
final class OrderItemEntity extends Equatable {
  final String? id;
  final ProductEntity? product;
  final int? price;
  final int? quantity;

  const OrderItemEntity({
    this.id,
    this.product,
    this.price,
    this.quantity,
  });

  @override
  List<Object?> get props => [id, product, price, quantity];
}

/// ProductEntity
final class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? slug;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final int? sold;
  final String? category;
  final String? occasion;
  final String? imgCover;
  final List<String>? images;

  const ProductEntity({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.sold,
    this.category,
    this.occasion,
    this.imgCover,
    this.images,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    slug,
    price,
    priceAfterDiscount,
    quantity,
    sold,
    category,
    occasion,
    imgCover,
    images,
  ];
}

/// ShippingAddressEntity
final class ShippingAddressEntity extends Equatable {
  final String? street;
  final String? city;
  final String? state;
  final String? phone;
  final String? lat;
  final String? long;

  const ShippingAddressEntity({
    this.street,
    this.city,
    this.state,
    this.phone,
    this.lat,
    this.long,
  });

  @override
  List<Object?> get props => [street, city, state, phone, lat, long];
}

/// StoreEntity
final class StoreEntity extends Equatable {
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? image;
  final String? latLong;

  const StoreEntity({
    this.name,
    this.address,
    this.phoneNumber,
    this.image,
    this.latLong,
  });

  @override
  List<Object?> get props => [name, address, phoneNumber, image, latLong];
}
