import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class GeneralCategoriesApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/GeneralCategories');
    } on DioException catch (e) {
      throw ApiError('Failed to load general categories', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/GeneralCategories', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to create general category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update(int id, Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/GeneralCategories/$id', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to update general category', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/GeneralCategories/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete general category', statusCode: e.response?.statusCode);
    }
  }
}


