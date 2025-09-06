import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toUserDataEntity", () {
    test(
      "when call toUserDataEntity with null values it should return UserDataEntity with null values",
      () {
        //Arrange
        final UserDataModel userData = UserDataModel(
          id: null,
          email: null,
          phone: null,
          lastName: null,
          firstName: null,
          gender: null,
          photo: null,
          addresses: null,
          wishlist: null,
          createdAt: null,
          role: null,
          passwordResetExpires: null,
          passwordResetCode: null,
          resetCodeVerified: null,
        );

        //Act
        final UserDataEntity actualResult = userData.toUserDataEntity();

        //Assert
        expect(actualResult.id, isNull);
        expect(actualResult.firstName, isNull);
        expect(actualResult.lastName, isNull);
        expect(actualResult.email, isNull);
        expect(actualResult.gender, isNull);
        expect(actualResult.phone, isNull);
        expect(actualResult.photo, isNull);
        expect(actualResult.role, isNull);
        expect(actualResult.wishlist, isNull);
        expect(actualResult.addresses, isNull);
        expect(actualResult.passwordResetCode, isNull);
      },
    );
    test(
      "when call toUserDataEntity with non-nullable values it should return UserDataEntity with correct values",
      () {
        //Arrange
        final UserDataModel userData = UserDataModel(
          id: "1",
          email: "ahmed@gmail.com",
          phone: "01116811741",
          firstName: "ahmed",
          lastName: "tarek",
          gender: "male",
          photo: "profilePic",
          addresses: ["address1", "address2"],
          wishlist: ["item1", "item2"],
          createdAt: "2020-01-01",
          role: "developer",
          passwordResetCode: "code1",
          passwordResetExpires: "At 2001",
          resetCodeVerified: true,
        );

        //Act
        final UserDataEntity actualResult = userData.toUserDataEntity();

        //Assert
        expect(actualResult.id, equals(userData.id));
        expect(actualResult.firstName, equals(userData.firstName));
        expect(actualResult.lastName, equals(userData.lastName));
        expect(actualResult.email, equals(userData.email));
        expect(actualResult.gender, equals(userData.gender));
        expect(actualResult.phone, equals(userData.phone));
        expect(actualResult.photo, equals(userData.photo));
        expect(actualResult.role, equals(userData.role));
        expect(actualResult.wishlist, equals(userData.wishlist));
        expect(actualResult.addresses, equals(userData.addresses));
        expect(
          actualResult.passwordResetCode,
          equals(userData.passwordResetCode),
        );
      },
    );
  });
}
