import 'package:dio/dio.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

class DioExceptions extends Failure {
  DioExceptions({required super.responseException});

  factory DioExceptions.handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.connectionTimeout,
            ),
          );
        case DioExceptionType.sendTimeout:
          return DioExceptions(
            responseException: ResponseException(message: AppText.sendTimeout),
          );
        case DioExceptionType.receiveTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.receiveTimeout,
            ),
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.requestCancelled,
            ),
          );
        case DioExceptionType.unknown:
          return DioExceptions(
            responseException: ResponseException(message: AppText.networkError),
          );
        case DioExceptionType.connectionError:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.connectionError,
            ),
          );
        default:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.unexpectedErrorOccurred,
            ),
          );
      }
    } else {
      return DioExceptions(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }

  static DioExceptions _handleBadResponse(Response? response) {
    return DioExceptions(
      responseException: ResponseException.handleException(response: response),
    );
  }
}
