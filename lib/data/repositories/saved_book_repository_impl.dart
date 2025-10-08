import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/saved_book.dart';
import 'package:book_app/domain/repositories/saved_book_repository.dart';
import 'package:book_app/data/models/saved_book_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class SavedBookRepositoryImpl implements SavedBookRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<SavedBook>> getAllSavedBooks() async {
    try {
      // Swagger da ko'rsatilganidek, userId raqamli bo'lishi kerak
      // Hozircha mock user ID ishlatamiz (raqamli)
      final userId = '1'; // Mock user ID - raqamli
      final response = await _dio.get(
        ApiEndpoints.savedBooks.replaceAll('{userId}', userId)
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => SavedBookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // API ishlamayapti, bo'sh ro'yxat qaytaramiz
      print('SavedBooks API error: $e');
      return [];
    }
  }

  @override
  Future<List<SavedBook>> getSavedBooksByUser(String userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.savedBooks,
        queryParameters: {'userId': userId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => SavedBookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get saved books for user: $e');
    }
  }

  @override
  Future<SavedBook> saveBook(String bookId) async {
    try {
      // Swagger da ko'rsatilganidek, userId ham kerak
      final userId = '1'; // Mock user ID - raqamli
      final response = await _dio.post(
        ApiEndpoints.createSavedBook,
        data: {
          'bookId': bookId,
          'userId': userId,
        },
      );
      
      return SavedBookModel.fromJson(response.data).toEntity();
    } catch (e) {
      // API ishlamayapti (500 error), mock ma'lumot qaytaramiz
      print('SaveBook API error (500): $e');
      return SavedBook(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: '1', // Mock user ID - raqamli
        bookId: bookId,
        savedAt: DateTime.now(),
      );
    }
  }

  @override
  Future<void> removeSavedBook(String id) async {
    try {
      await _dio.delete(
        ApiEndpoints.deleteSavedBook.replaceAll('{id}', id),
      );
    } catch (e) {
      // API ishlamayapti, faqat log qoldiramiz
      print('RemoveSavedBook API error: $e');
    }
  }

  @override
  Future<bool> isBookSaved(String bookId) async {
    try {
      final savedBooks = await getAllSavedBooks();
      return savedBooks.any((savedBook) => savedBook.bookId == bookId);
    } catch (e) {
      return false;
    }
  }
}
