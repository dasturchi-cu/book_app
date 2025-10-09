import 'package:book_app/domain/entities/borrowing.dart';

abstract class BorrowingRepository {
  Future<List<Borrowing>> getAllBorrowings();
  Future<List<Borrowing>> getMyBorrowings(String userId);
  Future<List<Borrowing>> getActiveBorrowings();
  Future<List<Borrowing>> getBorrowingRecords();
  Future<Borrowing> borrowBook({
    required String userId,
    required String bookId,
    required DateTime borrowDate,
    required DateTime dueDate,
    String? officerOrderCode,
  });
  Future<Borrowing> returnBook({
    required String userId,
    required String bookId,
    required DateTime returnedDate,
  });
  Future<int> getActiveBorrowedBooksCount();
  Future<int> getReturnedBooksCount();
  Future<Map<String, dynamic>> getLast7DaysBorrowStats();
  Future<Map<String, dynamic>> getBorrowSummary();
}