import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class EventsApiService extends BaseApiService {
  Future<void> create({
    required String name,
    String? description,
    DateTime? dateTime,
    List<String>? imagePaths,
  }) async {
    try {
      final form = FormData.fromMap({
        'Name': name,
        if (description != null) 'Description': description,
        if (dateTime != null) 'DateTime': dateTime.toIso8601String(),
        if (imagePaths != null)
          'Images': imagePaths.map((p) => MultipartFile.fromFileSync(p)).toList(),
      });
      await postRequest<void>('/api/Events/create', data: form);
    } on DioException catch (e) {
      throw ApiError('Failed to create event', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/Events/get-all');
    } on DioException catch (e) {
      throw ApiError('Failed to load events', statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> getById(int id) async {
    try {
      return await getRequest<Map<String, dynamic>>('/api/Events/get-by-id/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to load event', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update({
    required int id,
    String? name,
    String? description,
    DateTime? dateTime,
    List<String>? imagePaths,
  }) async {
    try {
      final form = FormData.fromMap({
        if (name != null) 'Name': name,
        if (description != null) 'Description': description,
        if (dateTime != null) 'DateTime': dateTime.toIso8601String(),
        if (imagePaths != null)
          'Images': imagePaths.map((p) => MultipartFile.fromFileSync(p)).toList(),
      });
      await putRequest<void>('/api/Events/update/$id', data: form);
    } on DioException catch (e) {
      throw ApiError('Failed to update event', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/Events/delete/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete event', statusCode: e.response?.statusCode);
    }
  }
}


