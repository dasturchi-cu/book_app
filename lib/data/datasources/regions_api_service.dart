import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class RegionsApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/Regions');
    } on DioException catch (e) {
      throw ApiError('Failed to load regions', statusCode: e.response?.statusCode);
    }
  }
}


