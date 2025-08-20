import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'splash_response.g.dart';

@JsonSerializable()
class SplashResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDataModel? user;

  SplashResponse({this.message, this.user});

  factory SplashResponse.fromJson(Map<String, dynamic> json) {
    return _$SplashResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SplashResponseToJson(this);
  }
}
