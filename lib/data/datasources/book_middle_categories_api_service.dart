import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class BookMiddleCategoriesApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/BookMiddleCategories');
    } on DioException catch (e) {
      throw ApiError('Failed to load middle categories', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/BookMiddleCategories', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to create middle category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update(int id, Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/BookMiddleCategories/$id', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to update middle category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/BookMiddleCategories/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete middle category', statusCode: e.response?.statusCode);
    }
  }
}


