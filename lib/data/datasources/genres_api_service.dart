import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class GenresApiService extends BaseApiService {
  Future<void> createGenre(String genreName) async {
    try {
      await postRequest<void>('/api/Genres/CreateGenre', data: genreName);
    } on DioException catch (e) {
      throw ApiError('Failed to create genre', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/Genres/GetAllGenre');
    } on DioException catch (e) {
      throw ApiError('Failed to load genres', statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> getById(int id) async {
    try {
      return await getRequest<Map<String, dynamic>>('/api/Genres/GetByIdGenre', query: {'id': id});
    } on DioException catch (e) {
      throw ApiError('Failed to load genre', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update({required int id, required String genreName}) async {
    try {
      await putRequest<void>('/api/Genres/Update', data: null);
      // The endpoint expects query params; fall back to client with direct call
      await client.put('/api/Genres/Update', queryParameters: {'id': id, 'genreName': genreName});
    } on DioException catch (e) {
      throw ApiError('Failed to update genre', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await client.delete('/api/Genres/Delete', queryParameters: {'id': id});
    } on DioException catch (e) {
      throw ApiError('Failed to delete genre', statusCode: e.response?.statusCode);
    }
  }

  Future<int> count() async {
    try {
      return await getRequest<int>('/api/Genres/GetCountGenre');
    } on DioException catch (e) {
      throw ApiError('Failed to count genres', statusCode: e.response?.statusCode);
    }
  }
}


