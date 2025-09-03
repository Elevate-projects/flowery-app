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
    this.discountPercentage,
  });

  String? productId;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? categoryId;
  String? occasionId;
  num? sold;
  String? discountPercentage;

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
