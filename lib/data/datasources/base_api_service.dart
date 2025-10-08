import 'package:dio/dio.dart';
import 'package:book_app/core/network/api_client.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseApiService {
  final Dio _dio = ApiClient.instance;

  Dio get client => _dio;

  Future<T> getRequest<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic data)? mapper,
  }) async {
    final response = await _dio.get(path, queryParameters: query);
    return mapper != null ? mapper(response.data) : response.data as T;
  }

  Future<T> postRequest<T>(
    String path, {
    dynamic data,
    T Function(dynamic data)? mapper,
  }) async {
    final response = await _dio.post(path, data: data);
    return mapper != null ? mapper(response.data) : response.data as T;
  }

  Future<T> putRequest<T>(
    String path, {
    dynamic data,
    T Function(dynamic data)? mapper,
  }) async {
    final response = await _dio.put(path, data: data);
    return mapper != null ? mapper(response.data) : response.data as T;
  }

  Future<void> deleteRequest(
    String path, {
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    await _dio.delete(path, queryParameters: query, data: data);
  }
}


