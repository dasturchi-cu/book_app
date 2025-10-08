import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/borrowing.dart';
import 'package:book_app/domain/repositories/borrowing_repository.dart';
import 'package:book_app/data/models/borrowing_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class BorrowingRepositoryImpl implements BorrowingRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<Borrowing>> getAllBorrowings() async {
    try {
      final response = await _dio.get(ApiEndpoints.borrowings);
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BorrowingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get borrowings: $e');
    }
  }

  @override
  Future<List<Borrowing>> getBorrowingsByUser(String userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.borrowings,
        queryParameters: {'userId': userId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BorrowingModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get borrowings for user: $e');
    }
  }

  @override
  Future<List<Borrowing>> getActiveBorrowings(String userId) async {
    try {
      final borrowings = await getBorrowingsByUser(userId);
      return borrowings.where((borrowing) => !borrowing.isReturned).toList();
    } catch (e) {
      throw Exception('Failed to get active borrowings: $e');
    }
  }

  @override
  Future<List<Borrowing>> getReturnedBorrowings(String userId) async {
    try {
      final borrowings = await getBorrowingsByUser(userId);
      return borrowings.where((borrowing) => borrowing.isReturned).toList();
    } catch (e) {
      throw Exception('Failed to get returned borrowings: $e');
    }
  }

  @override
  Future<Borrowing> borrowBook(String bookId) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createBorrowing,
        data: {'bookId': bookId},
      );
      
      return BorrowingModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to borrow book: $e');
    }
  }

  @override
  Future<Borrowing> returnBook(String id) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.returnBorrowing.replaceAll('{id}', id),
      );
      
      return BorrowingModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to return book: $e');
    }
  }

  @override
  Future<bool> isBookBorrowed(String bookId) async {
    try {
      final borrowings = await getAllBorrowings();
      return borrowings.any((borrowing) => 
          borrowing.bookId == bookId && !borrowing.isReturned);
    } catch (e) {
      return false;
    }
  }
}
