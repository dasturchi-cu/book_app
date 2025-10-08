import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/genre.dart';
import 'package:book_app/domain/repositories/genre_repository.dart';
import 'package:book_app/data/models/genre_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class GenreRepositoryImpl implements GenreRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<Genre>> getAllGenres() async {
    try {
      final response = await _dio.get(ApiEndpoints.genres);
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => GenreModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get genres: $e');
    }
  }

  @override
  Future<Genre> getGenreById(String id) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.genres}/$id',
      );
      
      return GenreModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to get genre: $e');
    }
  }

  @override
  Future<List<Genre>> searchGenres(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.genres,
        queryParameters: {'search': query},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => GenreModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local search
      final genres = await getAllGenres();
      final lowercaseQuery = query.toLowerCase();

      return genres.where((genre) {
        return genre.name.toLowerCase().contains(lowercaseQuery) ||
            genre.description?.toLowerCase().contains(lowercaseQuery) == true;
      }).toList();
    }
  }
}
