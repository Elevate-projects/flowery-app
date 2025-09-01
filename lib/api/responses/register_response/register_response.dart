import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDataModel? userRegisterModel;
  @JsonKey(name: "token")
  final String? token;

  RegisterResponse({this.message, this.userRegisterModel, this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterResponseToJson(this);
  }
}
