abstract class Endpoints {
  static const String baseUrl = 'https://flower.elevateegy.com';
  static const String loggedUserData = '/api/v1/auth/profile-data';
  static const String login = '/api/v1/auth/signin';
  static const String forgetPassword = '/api/v1/auth/forgotPassword';

  static const String register = '/api/v1/auth/signup';
  static const String categories = '/api/v1/categories';
  static const String products = '/api/v1/products';
  static const String editProfile = '/api/v1/auth/editProfile';
  static const String uploadProfileImage = '/api/v1/auth/upload-photo';
}
