import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return _$EditProfileRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileRequestToJson(this);
  }
}