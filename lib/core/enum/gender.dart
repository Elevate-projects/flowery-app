import 'package:flowery_app/core/constants/app_text.dart';

enum Gender {
  male,
  female
}


extension GenderX on Gender {
  String get value => name;

  String get label {
    switch (this) {
      case Gender.male:
        return AppText.genderMale;
      case Gender.female:
        return AppText.genderFemale;
    }
  }
}
