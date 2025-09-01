// To access user token or data from any place in the app,
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class FloweryMethodHelper {
  static UserDataEntity? userData;
  static String? currentUserToken;
}
