import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: "_id")
  final String? id;
  
  @JsonKey(name: "name")
  final String? name;
  
  @JsonKey(name: "slug")
  final String? slug;
  
  @JsonKey(name: "image")
  final String? image;
  
  @JsonKey(name: "createdAt")
  final String? createdAt;
  
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;

  const CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryModelToJson(this);
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isSuperAdmin: isSuperAdmin ?? false,
    );
  }
}