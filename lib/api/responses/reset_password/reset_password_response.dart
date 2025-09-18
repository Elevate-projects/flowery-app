import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "token")
  final String bearerToken;

  ResetPasswordResponse({
    required this.message,
    required this.bearerToken,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

   ResetPasswordResponseEntity toResetPasswordResponseEntity() {
    return ResetPasswordResponseEntity(
      message: message,
      bearerToken: bearerToken,
    );
   }
}
