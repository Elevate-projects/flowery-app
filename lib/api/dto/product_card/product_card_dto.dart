import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_card_dto.g.dart';

@JsonSerializable()
class ProductCardDto {
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
  @JsonKey(name: "id")
  final String? productId;

  ProductCardDto({
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
    this.productId,
  });

  factory ProductCardDto.fromJson(Map<String, dynamic> json) {
    return _$ProductCardDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductCardDtoToJson(this);
  }

  ProductCardEntity toProductCardEntity() {
    return ProductCardEntity(
      productId: productId,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      sold: sold,
      discountPercentage: getDiscountPercentage(),
    );
  }

  String? getDiscountPercentage() {
    if (priceAfterDiscount != null && price != null) {
      return "${((price! - priceAfterDiscount!) / price! * 100).toStringAsFixed(0)}%";
    }
    return null;
  }
}
