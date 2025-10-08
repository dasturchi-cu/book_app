import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class RatingsApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/Ratings/GetAllRatings');
    } on DioException catch (e) {
      throw ApiError('Failed to load ratings', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getAllById(int id) async {
    try {
      return await getRequest<List<dynamic>>('/api/Ratings/GetAllRatingById', query: {'id': id});
    } on DioException catch (e) {
      throw ApiError('Failed to load ratings by id', statusCode: e.response?.statusCode);
    }
  }

  Future<void> addRate(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/Ratings/AddRate', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to add rate', statusCode: e.response?.statusCode);
    }
  }

  Future<void> updateRate(Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/Ratings/UpdateRate', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to update rate', statusCode: e.response?.statusCode);
    }
  }

  Future<void> deleteRate(int id) async {
    try {
      await deleteRequest('/api/Ratings/DeleteRate', query: {'id': id});
    } on DioException catch (e) {
      throw ApiError('Failed to delete rate', statusCode: e.response?.statusCode);
    }
  }
}


