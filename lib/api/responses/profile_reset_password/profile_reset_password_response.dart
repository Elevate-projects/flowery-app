import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_reset_password_response.g.dart';

@JsonSerializable()
class ProfileResetPasswordResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "token")
  final String bearerToken;

  ProfileResetPasswordResponse({
    required this.message,
    required this.bearerToken,
  });

  factory ProfileResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResetPasswordResponseToJson(this);

   ProfileResetPasswordResponseEntity toProfileResetPasswordResponseEntity() {
    return ProfileResetPasswordResponseEntity(
      message: message,
      bearerToken: bearerToken,
    );
   }
}
