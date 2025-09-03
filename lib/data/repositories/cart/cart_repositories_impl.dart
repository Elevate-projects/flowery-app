// import 'package:flowery_app/api/client/api_result.dart';
// import 'package:flowery_app/api/requests/cart_request/cart_request.dart';
// import 'package:flowery_app/data/data_source/cart/remote_data_source/cart_remote_data_source.dart';
// import '../../../domain/entities/cart/cart_entities.dart';
// import '../../../domain/repositories/cart/cart_repositories.dart';
//
//
// class CartRepositoryImp implements CartRepository {
//   final CartRemoteDataSource _remoteDataSource;
//   const CartRepositoryImp(this._remoteDataSource);
//
//   @override
//   Future<Result<CartEntity>> cartPage({
//     required Cart_request request,
//     required String token,
//   }) async {
//     final result = await _remoteDataSource.cartPage(
//       request: request,
//       token: token,
//     );
//     if (result is Success) {
//       return Success(result.data.toCartEntity());
//     } else {
//       return Failure(responseException: (result as Failure).responseException);
//     }
//   }
// }
