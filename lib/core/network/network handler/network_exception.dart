import 'package:flutter/material.dart';
import 'package:news/core/constants/app_strings.dart';

/// Custom exception class used for handling all network-related errors.
///
/// Provides:
/// - Human-readable error messages
/// - HTTP status code mapping
/// - Common network failure factories (no internet, timeout, unknown)
/// - UI-friendly icon representation for error states
class NetworkException {
  /// Error message displayed to the user
  final String message;

  /// HTTP status code (if available)
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  /// Returns the error message as string
  @override
  String toString() => message;

  /// Creates exception based on HTTP status code
  factory NetworkException.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return NetworkException(AppStrings.badRequest, statusCode: statusCode);

      case 401:
        return NetworkException(
          AppStrings.unauthorized,
          statusCode: statusCode,
        );

      case 429:
        return NetworkException(AppStrings.apiLimit, statusCode: statusCode);

      case 500:
        return NetworkException(AppStrings.serverError, statusCode: statusCode);

      default:
        return NetworkException(
          '${AppStrings.somethingWentWrong} (code: $statusCode)',
          statusCode: statusCode,
        );
    }
  }

  /// No internet connection error
  factory NetworkException.noInternet() {
    return NetworkException(AppStrings.noInternet);
  }

  /// Request timeout error
  factory NetworkException.timeout() {
    return NetworkException(AppStrings.timeout);
  }

  /// Unexpected or unknown error
  factory NetworkException.unknown() {
    return NetworkException(AppStrings.unexpectedError);
  }

  /// Returns an icon suitable for displaying in UI error states
  IconData get icon {
    if (message.contains('internet')) {
      return Icons.wifi_off_rounded;
    }

    if (message.contains('limit')) {
      return Icons.hourglass_empty_rounded;
    }

    if (message.contains('timed out')) {
      return Icons.timer_off_rounded;
    }

    return Icons.error_outline;
  }
}
