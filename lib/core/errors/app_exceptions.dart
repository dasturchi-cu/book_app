class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  const NetworkException(super.message);
}

class ServerException extends ApiException {
  const ServerException(super.message, super.statusCode);
}

class CacheException extends ApiException {
  const CacheException(super.message);
}

class ValidationException extends ApiException {
  const ValidationException(super.message);
}

class AuthenticationException extends ApiException {
  const AuthenticationException(super.message);
}
