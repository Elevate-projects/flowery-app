import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AddressModel toAddressEntity", () {
    test(
      "when call toAddressEntity with null values it should return AddressEntity with null values",
      () {
        // Arrange
        final AddressModel addressModel = AddressModel(
          street: null,
          phone: null,
          city: null,
          lat: null,
          long: null,
          username: null,
          id: null,
        );

        // Act
        final AddressEntity actualResult = addressModel.toAddressEntity();

        // Assert
        expect(actualResult.street, equals(addressModel.street));
        expect(actualResult.phone, equals(addressModel.phone));
        expect(actualResult.city, equals(addressModel.city));
        expect(actualResult.lat, equals(addressModel.lat));
        expect(actualResult.long, equals(addressModel.long));
        expect(actualResult.username, equals(addressModel.username));
        expect(actualResult.id, equals(addressModel.id));
      },
    );

    test(
      "when call toAddressEntity with non-null values it should return AddressEntity with correct values",
      () {
        // Arrange
        final AddressModel addressModel = AddressModel(
          street: "123 Main St",
          phone: "+201234567890",
          city: "Cairo",
          lat: "30.0444",
          long: "31.2357",
          username: "Ahmed",
          id: "addr1",
        );

        // Act
        final AddressEntity actualResult = addressModel.toAddressEntity();

        // Assert
        expect(actualResult.street, equals(addressModel.street));
        expect(actualResult.phone, equals(addressModel.phone));
        expect(actualResult.city, equals(addressModel.city));
        expect(actualResult.lat, equals(addressModel.lat));
        expect(actualResult.long, equals(addressModel.long));
        expect(actualResult.username, equals(addressModel.username));
        expect(actualResult.id, equals(addressModel.id));
      },
    );
  });
}
