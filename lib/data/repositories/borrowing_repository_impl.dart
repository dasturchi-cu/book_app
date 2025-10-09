import 'package:book_app/domain/entities/borrowing.dart';
import 'package:book_app/domain/repositories/borrowing_repository.dart';
import 'package:book_app/data/datasources/borrowing_api_service.dart';
import 'package:book_app/data/models/borrowing_model.dart';
import 'package:book_app/core/errors/app_exceptions.dart';

class BorrowingRepositoryImpl implements BorrowingRepository {
  final BorrowingApiService _apiService;

  BorrowingRepositoryImpl({required BorrowingApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Borrowing>> getAllBorrowings() async {
    try {
      final borrowingModels = await _apiService.getAllBorrowings();
      return borrowingModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch borrowings: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching borrowings: $e');
    }
  }

  @override
  Future<List<Borrowing>> getMyBorrowings(String userId) async {
    try {
      final borrowingModels = await _apiService.getMyBorrowings(int.parse(userId));
      return borrowingModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch user borrowings: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching user borrowings: $e');
    }
  }

  @override
  Future<List<Borrowing>> getActiveBorrowings() async {
    try {
      final borrowingModels = await _apiService.getActiveBorrowings();
      return borrowingModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch active borrowings: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching active borrowings: $e');
    }
  }

  @override
  Future<List<Borrowing>> getBorrowingRecords() async {
    try {
      final borrowingModels = await _apiService.getBorrowingRecords();
      return borrowingModels.map((model) => model.toEntity()).toList();
    } on ApiException catch (e) {
      throw ApiException('Failed to fetch borrowing records: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while fetching borrowing records: $e');
    }
  }

  @override
  Future<Borrowing> borrowBook({
    required String userId,
    required String bookId,
    required DateTime borrowDate,
    required DateTime dueDate,
    String? officerOrderCode,
  }) async {
    try {
      final borrowingModel = await _apiService.borrowBook(
        userId: int.parse(userId),
        bookId: int.parse(bookId),
        borrowDate: borrowDate,
        dueDate: dueDate,
        officerOrderCode: officerOrderCode,
      );
      return borrowingModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to borrow book: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while borrowing book: $e');
    }
  }

  @override
  Future<Borrowing> returnBook({
    required String userId,
    required String bookId,
    required DateTime returnedDate,
  }) async {
    try {
      final borrowingModel = await _apiService.returnBook(
        userId: int.parse(userId),
        bookId: int.parse(bookId),
        returnedDate: returnedDate,
      );
      return borrowingModel.toEntity();
    } on ApiException catch (e) {
      throw ApiException('Failed to return book: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while returning book: $e');
    }
  }

  @override
  Future<int> getActiveBorrowedBooksCount() async {
    try {
      return await _apiService.getActiveBorrowedBooksCount();
    } on ApiException catch (e) {
      throw ApiException('Failed to get active borrowed books count: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting active borrowed books count: $e');
    }
  }

  @override
  Future<int> getReturnedBooksCount() async {
    try {
      return await _apiService.getReturnedBooksCount();
    } on ApiException catch (e) {
      throw ApiException('Failed to get returned books count: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting returned books count: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getLast7DaysBorrowStats() async {
    try {
      return await _apiService.getLast7DaysBorrowStats();
    } on ApiException catch (e) {
      throw ApiException('Failed to get last 7 days borrow stats: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting last 7 days borrow stats: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getBorrowSummary() async {
    try {
      return await _apiService.getBorrowSummary();
    } on ApiException catch (e) {
      throw ApiException('Failed to get borrow summary: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error while getting borrow summary: $e');
    }
  }
}