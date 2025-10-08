import 'package:dio/dio.dart';
import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/core/utils/token_storage.dart';

class ApiClient {
  static final Dio _dio = Dio();

  static void initialize() {
    _dio.options = BaseOptions(
      baseUrl: 'http://194.93.25.19:5050',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
      ErrorInterceptor(),
    ]);
  }

  static Dio get instance => _dio;
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      // Do not attach token for authentication endpoints
      final path = options.path;
      final isAuthCall = path.contains('/api/Users/LogIn') || path.contains('/api/Users/Create');

      if (!isAuthCall) {
        // Try read token from SharedPreferences
        // Note: interceptors can be async via handler.resolve, use then()
        TokenStorage.getToken().then((token) {
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        });
        return; // prevent double next
      }
    } catch (e) {
      // AuthController not found, continue without token
    }
    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    final msg = err.response?.data is Map
        ? ((err.response?.data)['message']?.toString() ?? err.message)
        : err.message;
    switch (status) {
      case 401:
        handler.reject(DioException(requestOptions: err.requestOptions, error: ApiError('Unauthorized', statusCode: 401)));
        return;
      case 403:
        handler.reject(DioException(requestOptions: err.requestOptions, error: ApiError('Forbidden', statusCode: 403)));
        return;
      case 404:
        handler.reject(DioException(requestOptions: err.requestOptions, error: ApiError('Not Found', statusCode: 404)));
        return;
      case 500:
        handler.reject(DioException(requestOptions: err.requestOptions, error: ApiError('Server Error', statusCode: 500)));
        return;
      default:
        handler.reject(DioException(requestOptions: err.requestOptions, error: ApiError(msg ?? 'Network error', statusCode: status)));
        return;
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}
