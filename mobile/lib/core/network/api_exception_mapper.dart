import 'package:dio/dio.dart';

import 'failure.dart';

/// Translates a raw [DioException] into a [Failure] so the rest of the app
/// never needs to know about Dio's exception types.
Failure mapDioExceptionToFailure(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const Failure.timeout('The request timed out. Please try again.');
    case DioExceptionType.connectionError:
      return const Failure.network('No internet connection.');
    case DioExceptionType.badResponse:
      return Failure.server(
        exception.response?.statusMessage ?? 'Server error',
        statusCode: exception.response?.statusCode,
      );
    case DioExceptionType.cancel:
      return const Failure.unknown('Request was cancelled.');
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
    default:
      return Failure.unknown(exception.message ?? 'Unknown error occurred.');
  }
}
