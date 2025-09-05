import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_model.g.dart';

@JsonSerializable()
class OccasionModel {
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

  const OccasionModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory OccasionModel.fromJson(Map<String, dynamic> json) {
    return _$OccasionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OccasionModelToJson(this);
  }

  OccasionEntity toEntity() {
    return OccasionEntity(
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