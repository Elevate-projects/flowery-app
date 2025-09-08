import 'package:flowery_app/api/client/api_result.dart';

abstract class LogoutRemoteDataSource {
  Future<Result<void>> logout();
}
