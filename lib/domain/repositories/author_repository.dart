import 'package:book_app/domain/entities/author.dart';

abstract class AuthorRepository {
  Future<List<Author>> getAuthors();
  Future<Author> getAuthorById(String id);
  Future<List<Author>> getAuthorBooks(String authorId);
  Future<Author> createAuthor({
    required String firstName,
    required String lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  });
  Future<Author> updateAuthor({
    required String id,
    required String firstName,
    required String lastName,
    String? middleName,
    String? about,
    String? country,
    String? city,
    String? imagePath,
  });
  Future<void> deleteAuthor(String id);
  Future<int> getAuthorCount();
}