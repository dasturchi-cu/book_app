import 'package:book_app/domain/entities/borrowing.dart';

abstract class BorrowingRepository {
  Future<List<Borrowing>> getAllBorrowings();
  Future<List<Borrowing>> getBorrowingsByUser(String userId);
  Future<List<Borrowing>> getActiveBorrowings(String userId);
  Future<List<Borrowing>> getReturnedBorrowings(String userId);
  Future<Borrowing> borrowBook(String bookId);
  Future<Borrowing> returnBook(String id);
  Future<bool> isBookBorrowed(String bookId);
}
