import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_reset_password_request.g.dart';

@JsonSerializable()
class ProfileResetPasswordRequest {
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "newPassword")
  final String newPassword;

  ProfileResetPasswordRequest({
    required this.password,
    required this.newPassword,
  });

  factory ProfileResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResetPasswordRequestToJson(this);
}