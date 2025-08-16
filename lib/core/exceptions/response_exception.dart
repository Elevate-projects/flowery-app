import 'package:dio/dio.dart';
import 'package:flowery_app/core/constants/app_text.dart';

class ResponseException {
  const ResponseException({required this.message});

  final String message;

  static ResponseException empty() => const ResponseException(
    message: AppText.noResponseReceivedMessage,
  );

  factory ResponseException.handleException({required Response? response}) {
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      return ResponseException(
        message: data['error'] ?? AppText.anUnknownErrorOccurred,
      );
    } else {
      return empty();
    }
  }
}
