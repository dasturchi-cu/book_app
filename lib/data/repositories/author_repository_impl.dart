import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/author.dart';
import 'package:book_app/domain/repositories/author_repository.dart';
import 'package:book_app/data/models/author_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<Author>> getAllAuthors() async {
    try {
      final response = await _dio.get(ApiEndpoints.authors);
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => AuthorModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get authors: $e');
    }
  }

  @override
  Future<Author> getAuthorById(String id) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.authors}/$id',
      );
      
      return AuthorModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to get author: $e');
    }
  }

  @override
  Future<List<Author>> searchAuthors(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.authors,
        queryParameters: {'search': query},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => AuthorModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local search
      final authors = await getAllAuthors();
      final lowercaseQuery = query.toLowerCase();

      return authors.where((author) {
        return author.name.toLowerCase().contains(lowercaseQuery) ||
            author.biography?.toLowerCase().contains(lowercaseQuery) == true;
      }).toList();
    }
  }
}
