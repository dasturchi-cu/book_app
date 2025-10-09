import 'package:book_app/domain/entities/genre.dart';
import 'package:book_app/domain/repositories/genre_repository.dart';
import 'package:book_app/data/datasources/genre_api_service.dart';
import 'package:book_app/data/models/genre_model.dart';
import 'package:book_app/core/errors/app_exceptions.dart';

class GenreRepositoryImpl implements GenreRepository {
  final GenreApiService _apiService;

  GenreRepositoryImpl({required GenreApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Genre>> getGenres() async {
    try {
      final genreModels = await _apiService.getGenres();
      return genreModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch genres: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching genres: $e');
    }
  }

  @override
  Future<Genre> getGenreById(String id) async {
    try {
      final genreModel = await _apiService.getGenreById(int.parse(id));
      return genreModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch genre: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching genre: $e');
    }
  }

  @override
  Future<Genre> createGenre(String genreName) async {
    try {
      final genreModel = await _apiService.createGenre(genreName);
      return genreModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to create genre: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while creating genre: $e');
    }
  }

  @override
  Future<Genre> updateGenre({
    required String id,
    required String genreName,
  }) async {
    try {
      final genreModel = await _apiService.updateGenre(
        id: int.parse(id),
        genreName: genreName,
      );
      return genreModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to update genre: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while updating genre: $e');
    }
  }

  @override
  Future<void> deleteGenre(String id) async {
    try {
      await _apiService.deleteGenre(int.parse(id));
    } on ApiException catch (e) {
      throw ApiException('Failed to delete genre: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while deleting genre: $e');
    }
  }

  @override
  Future<int> getGenreCount() async {
    try {
      return await _apiService.getGenreCount();
    } on ApiException catch (e) {
      throw ApiException('Failed to get genre count: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting genre count: $e');
    }
  }
}