import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AddressEntity extends Equatable {
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  String? username;
  String? id;

  AddressEntity({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  @override
  List<Object?> get props => [street, phone, city, lat, long, username, id];
}
