import 'package:flowery_app/utils/validations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("validations test", () {
    test("testing email validation cases", () {
      // Arrange

      // Valid emails
      final String validEmailCase1 = "ahmedtarek@gmail.com";
      final String validEmailCase2 = "ahmed.tarek@gmail.com";
      final String validEmailCase3 = "ahmed_tarek123@gmail.co.uk";
      final String validEmailCase4 = "a-tarek+123@gmail.com";

      //Invalid emails
      final String invalidEmailCase1 = "ahmedtarek@gmail";
      final String invalidEmailCase2 = "ahmedtarek@.com";
      final String invalidEmailCase3 = "ahmed.-tarek@gmail.com";
      final String invalidEmailCase4 = "ahmedtarek@gmail..com";
      final String invalidEmailCase5 = "ahmedtarek@gmail.c";
      final String invalidEmailCase6 = "";
      final String invalidEmailCase7 = "ahmedtarek@gmail.c@om";
      final String invalidEmailCase8 = "ahmedtarek@gmail.c om";
      final String invalidEmailCase9 = "ahmed..tarek@gmail.com";
      final String invalidEmailCase10 = "-ahmed@gmail.com";
      final String invalidEmailCase11 = ".ahmed@gmail.com";

      // Act

      // Valid email cases
      final validEmailResult1 = Validations.emailValidation(
        email: validEmailCase1,
      );
      final validEmailResult2 = Validations.emailValidation(
        email: validEmailCase2,
      );
      final validEmailResult3 = Validations.emailValidation(
        email: validEmailCase3,
      );
      final validEmailResult4 = Validations.emailValidation(
        email: validEmailCase4,
      );

      // Invalid email cases
      final invalidEmailResult1 = Validations.emailValidation(
        email: invalidEmailCase1,
      );
      final invalidEmailResult2 = Validations.emailValidation(
        email: invalidEmailCase2,
      );
      final invalidEmailResult3 = Validations.emailValidation(
        email: invalidEmailCase3,
      );
      final invalidEmailResult4 = Validations.emailValidation(
        email: invalidEmailCase4,
      );
      final invalidEmailResult5 = Validations.emailValidation(
        email: invalidEmailCase5,
      );
      final invalidEmailResult6 = Validations.emailValidation(
        email: invalidEmailCase6,
      );
      final invalidEmailResult7 = Validations.emailValidation(
        email: invalidEmailCase7,
      );
      final invalidEmailResult8 = Validations.emailValidation(
        email: invalidEmailCase8,
      );
      final invalidEmailResult9 = Validations.emailValidation(
        email: invalidEmailCase9,
      );
      final invalidEmailResult10 = Validations.emailValidation(
        email: invalidEmailCase10,
      );
      final invalidEmailResult11 = Validations.emailValidation(
        email: invalidEmailCase11,
      );
      // Assert
      expect(validEmailResult1, isNull);
      expect(validEmailResult2, isNull);
      expect(validEmailResult3, isNull);
      expect(validEmailResult4, isNull);

      expect(invalidEmailResult1, isNotNull);
      expect(invalidEmailResult2, isNotNull);
      expect(invalidEmailResult3, isNotNull);
      expect(invalidEmailResult4, isNotNull);
      expect(invalidEmailResult5, isNotNull);
      expect(invalidEmailResult6, isNotNull);
      expect(invalidEmailResult7, isNotNull);
      expect(invalidEmailResult8, isNotNull);
      expect(invalidEmailResult9, isNotNull);
      expect(invalidEmailResult10, isNotNull);
      expect(invalidEmailResult11, isNotNull);
    });

    test("testing password validation cases", () {
      // Arrange

      // Valid passwords
      final String validPasswordCase1 = "Ahmed\$123";
      final String validPasswordCase2 = "StrongPass#99";
      final String validPasswordCase3 = "Xyz@2024";

      // Invalid passwords
      final String invalidPasswordCase1 = "";
      final String invalidPasswordCase2 = "    ";
      final String invalidPasswordCase3 = "abc";
      final String invalidPasswordCase4 = "thisIsWayTooLongPassword123!";
      final String invalidPasswordCase5 = "abcdefgh";
      final String invalidPasswordCase6 = "abcdefgh1";
      final String invalidPasswordCase7 = "abcdefghA";
      final String invalidPasswordCase8 = "abcdefg1A";
      final String invalidPasswordCase9 = "Valid 123A\$";

      // Act

      // Valid password cases
      final validPasswordResult1 = Validations.passwordValidation(
        password: validPasswordCase1,
      );
      final validPasswordResult2 = Validations.passwordValidation(
        password: validPasswordCase2,
      );
      final validPasswordResult3 = Validations.passwordValidation(
        password: validPasswordCase3,
      );

      // Invalid password cases
      final invalidPasswordResult1 = Validations.passwordValidation(
        password: invalidPasswordCase1,
      );
      final invalidPasswordResult2 = Validations.passwordValidation(
        password: invalidPasswordCase2,
      );
      final invalidPasswordResult3 = Validations.passwordValidation(
        password: invalidPasswordCase3,
      );
      final invalidPasswordResult4 = Validations.passwordValidation(
        password: invalidPasswordCase4,
      );
      final invalidPasswordResult5 = Validations.passwordValidation(
        password: invalidPasswordCase5,
      );
      final invalidPasswordResult6 = Validations.passwordValidation(
        password: invalidPasswordCase6,
      );
      final invalidPasswordResult7 = Validations.passwordValidation(
        password: invalidPasswordCase7,
      );
      final invalidPasswordResult8 = Validations.passwordValidation(
        password: invalidPasswordCase8,
      );
      final invalidPasswordResult9 = Validations.passwordValidation(
        password: invalidPasswordCase9,
      );

      // Assert
      expect(validPasswordResult1, isNull);
      expect(validPasswordResult2, isNull);
      expect(validPasswordResult3, isNull);

      expect(invalidPasswordResult1, isNotNull);
      expect(invalidPasswordResult2, isNotNull);
      expect(invalidPasswordResult3, isNotNull);
      expect(invalidPasswordResult4, isNotNull);
      expect(invalidPasswordResult5, isNotNull);
      expect(invalidPasswordResult6, isNotNull);
      expect(invalidPasswordResult7, isNotNull);
      expect(invalidPasswordResult8, isNotNull);
      expect(invalidPasswordResult9, isNotNull);
    });

    test("testing user name (first/last name) validation cases", () {
      // Arrange
      final String validName1 = "Ahmed";
      final String validName2 = "Omar Elsadany";

      final String invalidName1 = "";
      final String invalidName2 = "   ";

      // Act
      final validResult1 = Validations.userNameValidation(name: validName1);
      final validResult2 = Validations.userNameValidation(name: validName2);

      final invalidResult1 = Validations.userNameValidation(name: invalidName1);
      final invalidResult2 = Validations.userNameValidation(name: invalidName2);


      // Assert
      expect(validResult1, isNull);
      expect(validResult2, isNull);

      expect(invalidResult1, isNotNull);
      expect(invalidResult2, isNotNull);
    });

    test("testing phone number validation cases", () {
      // Arrange
      final String validPhone1 = "01155027741";
      final String validPhone2 = "01234567890";

      final String invalidPhone1 = "";
      final String invalidPhone2 = "   ";
      final String invalidPhone3 = "12345"; // too short

      // Act
      final validResult1 = Validations.phoneValidation(phoneNumber: validPhone1);
      final validResult2 = Validations.phoneValidation(phoneNumber: validPhone2);

      final invalidResult1 = Validations.phoneValidation(phoneNumber: invalidPhone1);
      final invalidResult2 = Validations.phoneValidation(phoneNumber: invalidPhone2);
      final invalidResult3 = Validations.phoneValidation(phoneNumber: invalidPhone3);

      // Assert
      expect(validResult1, isNull);
      expect(validResult2, isNull);

      expect(invalidResult1, isNotNull);
      expect(invalidResult2, isNotNull);
      expect(invalidResult3, isNotNull);
    });
  });
}
