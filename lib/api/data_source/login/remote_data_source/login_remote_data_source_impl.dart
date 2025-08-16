// import 'package:injectable/injectable.dart';
//
// @Injectable(as: LoginRemoteDataSource)
// class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
//   final ApiClient _apiClient;
//   final SecureStorage _secureStorage;
//   const LoginRemoteDataSourceImpl(this._apiClient, this._secureStorage);
//   @override
//   Future<Result<UserDataEntity?>> login({required LoginRequest request}) async {
//     return executeApi(() async {
//       var response = await _apiClient.login(request: request);
//       ExamMethodHelper.currentUserToken = response.token;
//       await _secureStorage.saveUserToken(token: response.token);
//       var userData = response.userLoginData?.toUserDataEntity();
//       ExamMethodHelper.userData = userData;
//       return userData;
//     });
//   }
// }
