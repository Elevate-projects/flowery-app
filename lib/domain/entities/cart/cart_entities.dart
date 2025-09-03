class ProductEntity{
  final int? rateAvg;
  final int? rateCount;
  final String?Id;
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
  final String? createdAt;
  final String? updatedAt;
  final int? V;
  final bool? isSuperAdmin;
  final int? sold;

  ProductEntity({
     this.rateAvg,
     this.rateCount,
     this.Id,
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
});
}