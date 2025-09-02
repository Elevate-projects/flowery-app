import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequestDto {
  @JsonKey(name: "email")
  final String? email;

  ForgetPasswordRequestDto ({
    this.email,
  });

  factory ForgetPasswordRequestDto.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordRequestDtoToJson(this);
  }
}


