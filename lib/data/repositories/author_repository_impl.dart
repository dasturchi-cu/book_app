import 'package:book_app/domain/entities/author.dart';
import 'package:book_app/domain/repositories/author_repository.dart';
import 'package:book_app/data/datasources/author_api_service.dart';
import 'package:book_app/data/models/author_model.dart';
import 'package:book_app/core/errors/app_exceptions.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorApiService _apiService;

  AuthorRepositoryImpl({required AuthorApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Author>> getAuthors() async {
    try {
      final authorModels = await _apiService.getAuthors();
      return authorModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch authors: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching authors: $e');
    }
  }

  @override
  Future<Author> getAuthorById(String id) async {
    try {
      final authorModel = await _apiService.getAuthorById(int.parse(id));
      return authorModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch author: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching author: $e');
    }
  }

  @override
  Future<List<Author>> getAuthorBooks(String authorId) async {
    try {
      final authorModels = await _apiService.getAuthorBooks(int.parse(authorId));
      return authorModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch author books: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching author books: $e');
    }
  }

  @override
  Future<Author> createAuthor({
    required String firstName,
    required String lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  }) async {
    try {
      final authorModel = await _apiService.createAuthor(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        about: about,
        country: country,
        city: city,
        imagePath: imagePath,
      );
      return authorModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to create author: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while creating author: $e');
    }
  }

  @override
  Future<Author> updateAuthor({
    required String id,
    required String firstName,
    required String lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  }) async {
    try {
      final authorModel = await _apiService.updateAuthor(
        id: int.parse(id),
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        about: about,
        country: country,
        city: city,
        imagePath: imagePath,
      );
      return authorModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to update author: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while updating author: $e');
    }
  }

  @override
  Future<void> deleteAuthor(String id) async {
    try {
      await _apiService.deleteAuthor(int.parse(id));
    } on ApiException catch (e) {
      throw ApiException('Failed to delete author: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while deleting author: $e');
    }
  }

  @override
  Future<int> getAuthorCount() async {
    try {
      return await _apiService.getAuthorCount();
    } on ApiException catch (e) {
      throw ApiException('Failed to get author count: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting author count: $e');
    }
  }
}