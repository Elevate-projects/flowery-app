 import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_request_dto.g.dart';

@JsonSerializable()
class PaymentRequestDto {
  @JsonKey(name: "shippingAddress")
  final ShippingAddressDto? shippingAddress;

  PaymentRequestDto ({
    this.shippingAddress,
  });

  factory PaymentRequestDto.fromJson(Map<String, dynamic> json) {
    return _$PaymentRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentRequestDtoToJson(this);
  }
}

@JsonSerializable()
class ShippingAddressDto {
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

  ShippingAddressDto ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShippingAddressDtoToJson(this);
  }
  ShippingAddressDto shippingAddressToDto(ShippingAddressEntity entity){
    return ShippingAddressDto(
        city: entity.city,
        lat: entity.lat,
        long: entity.long,
        phone: entity.phone,
        street: entity.street
    );
  }


}


