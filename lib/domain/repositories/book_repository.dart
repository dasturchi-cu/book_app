import 'package:book_app/domain/entities/book.dart';
import 'package:dio/dio.dart';

abstract class BookRepository {
  Future<List<Book>> getAllBooks();
  Future<Book> getBookById(String id);
  Future<Book> createBook(FormData formData);
  Future<Book> updateBook(String id, FormData formData);
  Future<void> deleteBook(String id);
  Future<List<Book>> searchBooks(String query);
  Future<List<Book>> getBooksByCategory(String category);
  Future<List<Book>> getBooksByAuthor(String authorId);
  Future<List<Book>> getBooksByGenre(String genreId);
}
