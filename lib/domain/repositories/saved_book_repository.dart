import 'package:book_app/domain/entities/saved_book.dart';

abstract class SavedBookRepository {
  Future<List<SavedBook>> getAllSavedBooks();
  Future<List<SavedBook>> getSavedBooksByUser(String userId);
  Future<SavedBook> saveBook(String bookId);
  Future<void> removeSavedBook(String id);
  Future<bool> isBookSaved(String bookId);
}
