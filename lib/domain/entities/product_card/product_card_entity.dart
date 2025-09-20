import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductCardEntity extends Equatable {
  const ProductCardEntity({
    this.productId,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.categoryId,
    this.occasionId,
    this.sold,
    this.discountPercentage,
    this.createdAt,
  });

  final String? productId;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? categoryId;
  final String? occasionId;
  final int? sold;
  final String? discountPercentage;
  final String? createdAt;

  @override
  List<Object?> get props => [
    productId,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    categoryId,
    occasionId,
    sold,
    discountPercentage,
    createdAt,
  ];
}