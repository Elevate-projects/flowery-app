import 'package:flowery_app/core/enum/gender.dart';

sealed class RegisterIntent {}

class InitializedRegisterIntent extends RegisterIntent {}

class TogglePasswordVisibilityIntent extends RegisterIntent{}

class ToggleConfirmPasswordVisibilityIntent extends RegisterIntent{}

class RegisterWithDataIntent extends RegisterIntent {}

class ChangeGenderIntent extends RegisterIntent {
  final Gender gender;
  ChangeGenderIntent({required this.gender});
}
class AlreadyHaveAccountIntent extends RegisterIntent {}