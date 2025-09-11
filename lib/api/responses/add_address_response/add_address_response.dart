import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_response.g.dart';

@JsonSerializable()
class AddAddressResponse extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "address")
  final List<AddressModel>? address;

  const AddAddressResponse({this.message, this.address});

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$AddAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddAddressResponseToJson(this);
  }

  @override
  List<Object?> get props => [message, address];
}
