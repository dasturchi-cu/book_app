import 'package:book_app/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:book_app/core/errors/api_error.dart';

class VideoLessonsApiService {
  final Dio _dio = ApiClient.instance;

  // Get all video lessons
  Future<List<Map<String, dynamic>>> getAllVideoLessons() async {
    try {
      final response = await _dio.get('/api/VideoLessons/GetAll');
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiError('Failed to fetch video lessons: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Get video lesson by ID
  Future<Map<String, dynamic>> getVideoLessonById(String id) async {
    try {
      final response = await _dio.get('/api/VideoLessons/Get/$id');
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to fetch video lesson: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Create video lesson
  Future<Map<String, dynamic>> createVideoLesson(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/VideoLessons/Create', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to create video lesson: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Update video lesson
  Future<Map<String, dynamic>> updateVideoLesson(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/VideoLessons/Update/$id', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to update video lesson: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Delete video lesson
  Future<void> deleteVideoLesson(String id) async {
    try {
      await _dio.delete('/api/VideoLessons/Delete/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete video lesson: ${e.message}', statusCode: e.response?.statusCode);
    }
  }
}

class RequirementsApiService {
  final Dio _dio = ApiClient.instance;

  // Get all requirements
  Future<List<Map<String, dynamic>>> getAllRequirements() async {
    try {
      final response = await _dio.get('/api/Requirements/GetAll');
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiError('Failed to fetch requirements: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Get requirement by ID
  Future<Map<String, dynamic>> getRequirementById(String id) async {
    try {
      final response = await _dio.get('/api/Requirements/Get/$id');
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to fetch requirement: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Create requirement
  Future<Map<String, dynamic>> createRequirement(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/Requirements/Create', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to create requirement: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Update requirement
  Future<Map<String, dynamic>> updateRequirement(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/Requirements/Update/$id', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to update requirement: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Delete requirement
  Future<void> deleteRequirement(String id) async {
    try {
      await _dio.delete('/api/Requirements/Delete/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete requirement: ${e.message}', statusCode: e.response?.statusCode);
    }
  }
}

class TextbooksApiService {
  final Dio _dio = ApiClient.instance;

  // Get all textbooks
  Future<List<Map<String, dynamic>>> getAllTextbooks() async {
    try {
      final response = await _dio.get('/api/Textbooks/GetAll');
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiError('Failed to fetch textbooks: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Get textbook by ID
  Future<Map<String, dynamic>> getTextbookById(String id) async {
    try {
      final response = await _dio.get('/api/Textbooks/Get/$id');
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to fetch textbook: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Create textbook
  Future<Map<String, dynamic>> createTextbook(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/Textbooks/Create', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to create textbook: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Update textbook
  Future<Map<String, dynamic>> updateTextbook(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/Textbooks/Update/$id', data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError('Failed to update textbook: ${e.message}', statusCode: e.response?.statusCode);
    }
  }

  // Delete textbook
  Future<void> deleteTextbook(String id) async {
    try {
      await _dio.delete('/api/Textbooks/Delete/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete textbook: ${e.message}', statusCode: e.response?.statusCode);
    }
  }
}
