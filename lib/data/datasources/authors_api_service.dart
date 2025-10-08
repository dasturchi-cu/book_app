import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class AuthorsApiService extends BaseApiService {
  Future<List<dynamic>> getAll() async {
    try {
      return await getRequest<List<dynamic>>('/api/Author/GetAll');
    } on DioException catch (e) {
      throw ApiError('Failed to load authors', statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> getById(int id) async {
    try {
      return await getRequest<Map<String, dynamic>>('/api/Author/Get/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to load author', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getAuthorBooks(int id) async {
    try {
      return await getRequest<List<dynamic>>('/api/Author/Get-Author-Books/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to load author books', statusCode: e.response?.statusCode);
    }
  }

  Future<void> create({
    required String firstName,
    required String lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  }) async {
    try {
      final form = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        if (middleName != null) 'MiddleName': middleName,
        if (about != null) 'About': about,
        if (country != null) 'Country': country,
        if (city != null) 'City': city,
        if (imagePath != null) 'Image': MultipartFile.fromFileSync(imagePath),
      });
      await postRequest<void>('/api/Author/Create', data: form);
    } on DioException catch (e) {
      throw ApiError('Failed to create author', statusCode: e.response?.statusCode);
    }
  }

  Future<void> update({
    required int id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  }) async {
    try {
      final form = FormData.fromMap({
        if (firstName != null) 'FirstName': firstName,
        if (lastName != null) 'LastName': lastName,
        if (middleName != null) 'MiddleName': middleName,
        if (about != null) 'About': about,
        if (country != null) 'Country': country,
        if (city != null) 'City': city,
        if (imagePath != null) 'Image': MultipartFile.fromFileSync(imagePath),
      });
      await putRequest<void>('/api/Author/Update/$id', data: form);
    } on DioException catch (e) {
      throw ApiError('Failed to update author', statusCode: e.response?.statusCode);
    }
  }

  Future<void> delete(int id) async {
    try {
      await deleteRequest('/api/Author/Delete/$id');
    } on DioException catch (e) {
      throw ApiError('Failed to delete author', statusCode: e.response?.statusCode);
    }
  }
}


