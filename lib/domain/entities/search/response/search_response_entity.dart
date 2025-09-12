class SearchResponseEntity {
  final String message;
  final MetadataEntity metadata;
  final List<ProductEntity> products;

  SearchResponseEntity({
    required this.message,
    required this.metadata,
    required this.products,
  });
}

class MetadataEntity {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;

  MetadataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });
}

class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final int v;
  final bool isSuperAdmin;
  final int sold;
  final int rateAvg;
  final int rateCount;
  final dynamic favoriteId;
  final bool isInWishlist;

  ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
    this.favoriteId,
    required this.isInWishlist,
  });
}
