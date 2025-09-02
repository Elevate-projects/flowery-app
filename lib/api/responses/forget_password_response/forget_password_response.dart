import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ForgetPasswordResponseModel ({
    this.message,
    this.info,
  });

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponseModelToJson(this);
  }
  ForgetPasswordEntity toForgetPasswordEntity(){
    return ForgetPasswordEntity(
      message: message,
      info: info ,
    );
  }

}


