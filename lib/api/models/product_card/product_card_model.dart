import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_card_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductCardModel {
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
  final int? v;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;

  ProductCardModel({
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

  factory ProductCardModel.fromJson(Map<String, dynamic> json) {
    return _$ProductCardModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductCardModelToJson(this);
  }

  ProductCardEntity toProductCardEntity() {
    return ProductCardEntity(
      productId: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity,
      categoryId: category,
      occasionId: occasion,
      sold: sold,
      createdAt: createdAt,
      discountPercentage: getDiscountPercentage() ?? "0%",
    );
  }

  String? getDiscountPercentage() {
    if (priceAfterDiscount != null && price != null && price != 0) {
      return "${((price! - priceAfterDiscount!) / price! * 100).toStringAsFixed(0)}%";
    }
    return null;
  }
}
