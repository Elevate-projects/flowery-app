import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flowery_app/domain/repositories/get_user_order/get_user_order_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetUserUseCase{
  final GetUserOrderRepositories repositories;
  GetUserUseCase(this.repositories);
  Future<Result<GetUserOrderEntity>> getUserOrder() {
    return repositories.getUserOrder();
  }
}