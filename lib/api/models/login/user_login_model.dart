// import 'package:exam_app/domain/entities/login/user_data_entity.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'user_login_model.g.dart';
//
// @JsonSerializable()
// class UserModel {
//   @JsonKey(name: "_id")
//   final String? id;
//   @JsonKey(name: "username")
//   final String? username;
//   @JsonKey(name: "firstName")
//   final String? firstName;
//   @JsonKey(name: "lastName")
//   final String? lastName;
//   @JsonKey(name: "email")
//   final String? email;
//   @JsonKey(name: "phone")
//   final String? phone;
//   @JsonKey(name: "role")
//   final String? role;
//   @JsonKey(name: "isVerified")
//   final bool? isVerified;
//   @JsonKey(name: "createdAt")
//   final String? createdAt;
//
//   UserModel({
//     this.id,
//     this.username,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.role,
//     this.isVerified,
//     this.createdAt,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return _$UserModelFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$UserModelToJson(this);
//   }
//
//   UserDataEntity toUserDataEntity() {
//     return UserDataEntity(
//       userId: id,
//       username: username,
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       phone: phone,
//     );
//   }
// }
