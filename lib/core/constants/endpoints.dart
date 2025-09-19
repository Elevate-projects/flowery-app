abstract class Endpoints {
  static const String baseUrl = 'https://flower.elevateegy.com';
  static const String loggedUserData = '/api/v1/auth/profile-data';
  static const String login = '/api/v1/auth/signin';
  static const String forgetPassword = '/api/v1/auth/forgotPassword';
  static const String home = '/api/v1/home';
  static const String register = '/api/v1/auth/signup';
  static const String categories = '/api/v1/categories';
  static const String products = '/api/v1/products';
  static const String editProfile = '/api/v1/auth/editProfile';
  static const String uploadProfileImage = '/api/v1/auth/upload-photo';
  static const String logout = '/api/v1/auth/logout';
  static const String addProductToCart = '/api/v1/cart';
  static const String resendCode = '/api/v1/auth/forgotPassword';
  static const String verification = '/api/v1/auth/verifyResetCode';
  static const String resetPassword = '/api/v1/auth/resetPassword';
  static const String removeAddress = '/api/v1/addresses/{addressId}';
  static const String getLoggedUserCart = '/api/v1/cart';
  static const String updateCartQuantity = '/api/v1/cart/{productId}';
  static const String deleteCartQuantity = '/api/v1/cart/{productId}';
  static const String addAddress = '/api/v1/addresses';
  static const String payment = '/api/v1/orders/checkout';
  static const String cash = '/api/v1/orders';


}
