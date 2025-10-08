import 'package:book_app/domain/entities/author.dart';

abstract class AuthorRepository {
  Future<List<Author>> getAllAuthors();
  Future<Author> getAuthorById(String id);
  Future<List<Author>> searchAuthors(String query);
}
