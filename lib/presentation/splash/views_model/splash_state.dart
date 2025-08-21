import 'package:flowery_app/core/exceptions/response_exception.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class FetchUserDataSuccessState extends SplashState {}

final class FetchUserDataLoadingState extends SplashState {}

final class FetchUserDataFailureState extends SplashState {
  FetchUserDataFailureState({required this.errorData});
  final ResponseException errorData;
}

final class LoginNavigationState extends SplashState {}
