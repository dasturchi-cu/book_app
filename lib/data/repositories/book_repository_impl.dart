import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/book.dart';
import 'package:book_app/domain/repositories/book_repository.dart';
import 'package:book_app/data/models/book_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';

class BookRepositoryImpl implements BookRepository {
  final Dio _dio = ApiClient.instance;
  List<Book> _cachedBooks = [];

  @override
  Future<List<Book>> getAllBooks() async {
    try {
      final response = await _dio.get(ApiEndpoints.books);
      final List<dynamic> jsonList = response.data;
      
      final books = jsonList
          .map((json) => BookModel.fromJson(json).toEntity())
          .toList();
      
      _cachedBooks = books;
      return books;
    } catch (e) {
      // Fallback to mock data if API fails
      if (_cachedBooks.isNotEmpty) {
        return _cachedBooks;
      }

      try {
        final jsonString = await rootBundle.loadString(
          AppConstants.mockBooksPath,
        );
        final List<dynamic> jsonList = json.decode(jsonString);

        _cachedBooks = jsonList
            .map((json) => BookModel.fromJson(json).toEntity())
            .toList();

        return _cachedBooks;
      } catch (mockError) {
        throw Exception('Failed to load books from API and mock data: $e');
      }
    }
  }

  @override
  Future<Book> getBookById(String id) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bookById.replaceAll('{id}', id),
      );
      return BookModel.fromJson(response.data).toEntity();
    } catch (e) {
      // Fallback to cached books
      final books = await getAllBooks();
      try {
        return books.firstWhere((book) => book.id == id);
      } catch (e) {
        throw Exception('Book with id $id not found');
      }
    }
  }

  @override
  Future<Book> createBook(FormData formData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.createBook,
        data: formData,
      );
      return BookModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to create book: $e');
    }
  }

  @override
  Future<Book> updateBook(String id, FormData formData) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateBook.replaceAll('{id}', id),
        data: formData,
      );
      return BookModel.fromJson(response.data).toEntity();
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  @override
  Future<void> deleteBook(String id) async {
    try {
      await _dio.delete(
        ApiEndpoints.deleteBook.replaceAll('{id}', id),
      );
      // Remove from cache
      _cachedBooks.removeWhere((book) => book.id == id);
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }

  @override
  Future<List<Book>> searchBooks(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.books,
        queryParameters: {'search': query},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local search
      final books = await getAllBooks();
      final lowercaseQuery = query.toLowerCase();

      return books.where((book) {
        return book.title.toLowerCase().contains(lowercaseQuery) ||
            book.author.toLowerCase().contains(lowercaseQuery) ||
            book.description?.toLowerCase().contains(lowercaseQuery) == true ||
            book.categories.any(
              (category) => category.toLowerCase().contains(lowercaseQuery),
            );
      }).toList();
    }
  }

  @override
  Future<List<Book>> getBooksByCategory(String category) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.books,
        queryParameters: {'category': category},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local filtering
      final books = await getAllBooks();
      return books
          .where(
            (book) => book.categories.any(
              (cat) => cat.toLowerCase() == category.toLowerCase(),
            ),
          )
          .toList();
    }
  }

  @override
  Future<List<Book>> getBooksByAuthor(String authorId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.books,
        queryParameters: {'authorId': authorId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local filtering
      final books = await getAllBooks();
      return books
          .where((book) => book.author == authorId)
          .toList();
    }
  }

  @override
  Future<List<Book>> getBooksByGenre(String genreId) async {
    try {
      final response = await _dio.get(
          ApiEndpoints.books,
        queryParameters: {'genreId': genreId},
      );
      final List<dynamic> jsonList = response.data;
      
      return jsonList
          .map((json) => BookModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Fallback to local filtering
      final books = await getAllBooks();
      return books
          .where((book) => book.categories.contains(genreId))
          .toList();
    }
  }
}