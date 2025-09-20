import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_request_model.g.dart';

@JsonSerializable()
class AddAddressRequestModel extends Equatable {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;

  const AddAddressRequestModel({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddAddressRequestModel.fromJson(Map<String, dynamic> json) {
    return _$AddAddressRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddAddressRequestModelToJson(this);
  }

  @override
  List<Object?> get props => [street, phone, city, lat, long, username];
}
