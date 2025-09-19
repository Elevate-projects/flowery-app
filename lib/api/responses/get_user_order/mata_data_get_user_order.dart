import 'package:flowery_app/domain/entities/get_user_order/mata_data_get_user_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'mata_data_get_user_order.g.dart';
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
      currentPage: currentPage,
      totalPages: totalPages,
      limit: limit,
      totalItems: totalItems,
    );
  }
}