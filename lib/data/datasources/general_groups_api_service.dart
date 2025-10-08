import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class GeneralGroupsApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/GeneralGroups');
    } on DioException catch (e) {
      throw ApiError('Failed to load general groups', statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> getById(int id) async {
    try {
      // Swagger shows only PUT/DELETE by id; if GET needed, filter client-side
      final all = await getAll();
      return Map<String, dynamic>.from(all.firstWhere((e) => (e as Map)['id'] == id) as Map);
    } on DioException catch (e) {
      throw ApiError('Failed to load general group', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/GeneralGroups', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to create general group', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update(int id, Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/GeneralGroups/$id', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to update general group', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/GeneralGroups/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete general group', statusCode: e.response?.statusCode);
    }
  }
}


