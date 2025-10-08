import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class SavedBooksApiService extends BaseApiService {
  Future<List<dynamic>> getByUser(int userId) async {
    try {
      return await getRequest<List<dynamic>>('/api/SavedBooks/user/$userId');
    } on DioException catch (e) {
      throw ApiError('Failed to load saved books', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/SavedBooks', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to save book', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/SavedBooks/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to remove saved book', statusCode: e.response?.statusCode);
    }
  }
}


