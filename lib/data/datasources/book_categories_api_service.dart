import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class BookCategoriesApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/BookCategories');
    } on DioException catch (e) {
      throw ApiError('Failed to load book categories', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/BookCategories', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to create book category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update(int id, Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/BookCategories/$id', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to update book category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/BookCategories/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete book category', statusCode: e.response?.statusCode);
    }
  }
}


