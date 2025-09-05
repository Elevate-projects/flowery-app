import 'package:flowery_app/api/client/api_result.dart';

abstract class LogoutRepository {
  Future<Result<void>> logout();
}
