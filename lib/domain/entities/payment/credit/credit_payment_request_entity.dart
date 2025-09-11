
import 'package:flowery_app/api/requests/payment/payment_request_dto.dart';

class PaymentRequestEntity {
  final ShippingAddressEntity? shippingAddress;

  PaymentRequestEntity({
    this.shippingAddress,
  });



}
ShippingAddressDto shippingAddressToDto(
    ShippingAddressEntity entity
    ){
  return ShippingAddressDto(
      street: entity.street,
      phone: entity.phone,
      long: entity.long,
      lat: entity.lat,
      city: entity.city
  );
}

class ShippingAddressEntity {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;

  ShippingAddressEntity({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });


}
