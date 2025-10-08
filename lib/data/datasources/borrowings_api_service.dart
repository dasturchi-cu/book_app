import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:dio/dio.dart';

class BorrowingsApiService extends BaseApiService {
  Future<void> borrow(Map<String, dynamic> dto) async {
    try {
      await postRequest<void>('/api/Borrowings/BorrowBook/borrow', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to borrow book', statusCode: e.response?.statusCode);
    }
  }

  Future<void> returnBook(Map<String, dynamic> dto) async {
    try {
      await putRequest<void>('/api/Borrowings/ReturnBook/return', data: dto);
    } on DioException catch (e) {
      throw ApiError('Failed to return book', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> myBorrowings(int userId) async {
    try {
      return await getRequest<List<dynamic>>('/api/Borrowings/MyBorrowingsForUserId/my', query: {'userId': userId});
    } on DioException catch (e) {
      throw ApiError('Failed to load my borrowings', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getAllBorrowings() async {
    try {
      return await getRequest<List<dynamic>>('/api/Borrowings/AllBOrrowings/borrowings');
    } on DioException catch (e) {
      throw ApiError('Failed to load borrowings', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> getActiveBorrowings() async {
    try {
      return await getRequest<List<dynamic>>('/api/Borrowings/GetActiveBorrowings');
    } on DioException catch (e) {
      throw ApiError('Failed to load active borrowings', statusCode: e.response?.statusCode);
    }
  }

  Future<List<dynamic>> borrowingRecords() async {
    try {
      return await getRequest<List<dynamic>>('/api/Borrowings/BorrowingRecords');
    } on DioException catch (e) {
      throw ApiError('Failed to load borrowing records', statusCode: e.response?.statusCode);
    }
  }

  Future<int> countActiveBorrowedBooks() async {
    try {
      return await getRequest<int>('/api/Borrowings/GetActiveBorrowedBooksCount/count-active-borrowed-books');
    } on DioException catch (e) {
      throw ApiError('Failed to count active borrowed books', statusCode: e.response?.statusCode);
    }
  }

  Future<int> countReturnedBooks() async {
    try {
      return await getRequest<int>('/api/Borrowings/GetReturnedBooksCount/count-returned-books');
    } on DioException catch (e) {
      throw ApiError('Failed to count returned books', statusCode: e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> borrowSummary() async {
    try {
      return await getRequest<Map<String, dynamic>>('/api/Borrowings/GetBorrowSummary');
    } on DioException catch (e) {
      throw ApiError('Failed to load borrow summary', statusCode: e.response?.statusCode);
    }
  }
}


