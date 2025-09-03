import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  CategoryEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.productsCount,
  });

  String? id;
  String? name;
  String? slug;
  String? image;
  num? productsCount;

  @override
  List<Object?> get props => [id, name, slug, image, productsCount];
}
