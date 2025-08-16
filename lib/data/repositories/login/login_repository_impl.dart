// import 'package:injectable/injectable.dart';
//
// @Injectable(as: LoginRepository)
// class LoginRepositoryImpl implements LoginRepository {
//   final LoginRemoteDataSource loginRemoteDataSource;
//   @factoryMethod
//   const LoginRepositoryImpl({required this.loginRemoteDataSource});
//
//   @override
//   Future<Result<UserDataEntity?>> login({required LoginRequest request}) async {
//     return await loginRemoteDataSource.login(request: request);
//   }
// }
