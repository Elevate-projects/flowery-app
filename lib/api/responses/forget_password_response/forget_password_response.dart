import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ForgetPasswordResponseDto ({
    this.message,
    this.info,
  });

  factory ForgetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponseDtoToJson(this);
  }
  static ForgetPasswordResponseEntity toEntity(ForgetPasswordResponseDto dto) {
    return ForgetPasswordResponseEntity(
      message: dto.message,
      info: dto.info,
    );
  }
}


