class ProductCardEntity {
  final String? productId;
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
  final int? sold;
  final double? rateAvg;
  final int? rateCount;
  final String? discountPercentage;
  final bool isInStock;

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
    this.category,
    this.occasion,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.discountPercentage,
    this.isInStock = false,
  });
}