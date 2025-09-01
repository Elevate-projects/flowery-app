import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_register_model.g.dart';

@JsonSerializable()
class UserRegisterModel {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "wishlist")
  final List<String>? wishlist;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "addresses")
  final List<String>? addresses;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserRegisterModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return _$UserRegisterModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRegisterModelToJson(this);
  }

    UserDataEntity toUserDataEntity() {
    return UserDataEntity(
      userId: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      photo: photo,
      gender: gender,
      role: role,
      createdAt: createdAt,
      wishlist: wishlist,
      addresses: addresses,
    );
  }
}

