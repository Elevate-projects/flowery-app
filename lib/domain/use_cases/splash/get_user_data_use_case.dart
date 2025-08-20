import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/splash/splash_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUseCase {
  final SplashRepository _splashRepository;
  const GetUserDataUseCase(this._splashRepository);

  Future<Result<UserDataEntity?>> invoke() async {
    return await _splashRepository.getUserData();
  }
}
