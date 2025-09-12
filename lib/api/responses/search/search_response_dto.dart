import 'package:flowery_app/domain/entities/search/response/search_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response_dto.g.dart';

@JsonSerializable()
class SearchResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "products")
  final List<Products>? products;

  SearchResponseDto ({
    this.message,
    this.metadata,
    this.products,
  });

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SearchResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchResponseDtoToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Metadata ({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage ?? 1,
      totalPages: totalPages ?? 1,
      limit: limit ?? 20,
      totalItems: totalItems ?? 0,
    );
  }

}

@JsonSerializable()
class Products {
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
  final int? V;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "favoriteId")
  final dynamic favoriteId;
  @JsonKey(name: "isInWishlist")
  final bool? isInWishlist;

  Products ({
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
    this.V,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.favoriteId,
    this.isInWishlist,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return _$ProductsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsToJson(this);
  }
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      v: V ?? 0,
      isSuperAdmin: isSuperAdmin ?? false,
      sold: sold ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      favoriteId: favoriteId,
      isInWishlist: isInWishlist ?? false,
    );
  }
}


