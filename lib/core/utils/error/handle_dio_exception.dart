import 'package:dio/dio.dart';
import 'failures.dart';
import 'not_found_error.dart';

class HandleDioException {
  static Failure handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure(message: 'Connection timeout. Please try again.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final serverMessage = e.response?.data
            .toString(); // You can parse this more cleanly if it's JSON or XML

        if (statusCode == 400) {
          return BadRequestFailure(
              message: 'Bad request. ${serverMessage ?? ''}');
        } else if (statusCode == 401) {
          return AuthFailure(message:serverMessage ?? 'Unauthorized. Please log in again.');
        } else if (statusCode == 403) {
          return AuthFailure(message:serverMessage ?? 'Forbidden access.');
        } else if (statusCode == 404) {
          final response = NotFoundErrorResponse.fromXml(e.response?.data);
          return NotFoundFailure(message:response.message );
        } else if (statusCode >= 500) {

          return const ServerFailure(message: '' );
        } else {
          return ServerFailure(
              message: serverMessage ?? 'Unknown server error.');
        }

      case DioExceptionType.cancel:
        return const UnexpectedFailure(message: 'Request was cancelled.');

      case DioExceptionType.unknown:
        return const UnexpectedFailure(
            message: 'Something went wrong. Please try again.');

      case DioExceptionType.connectionError:
        return const OfflineFailure(message: 'No internet connection.');

      default:
        return const UnexpectedFailure(message: 'Unexpected error occurred.');
    }
  }
}
