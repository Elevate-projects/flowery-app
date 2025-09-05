import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductCardEntity extends Equatable {
  ProductCardEntity({
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
    this.rateAvg,
    this.rateCount,
    this.discountPercentage,
    this.isInStock
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
  final double? rateAvg;
  final int? rateCount;
  final String? discountPercentage;
  final bool? isInStock;

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
  ];
}