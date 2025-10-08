import 'package:book_app/core/errors/api_error.dart';
import 'package:book_app/data/datasources/base_api_service.dart';
import 'package:book_app/data/models/book_model.dart';
import 'package:dio/dio.dart';

class BooksApiService extends BaseApiService {
  List<BookModel> _mapBooksList(dynamic data) {
    if (data is List) {
      return data.map((e) {
        final map = Map<String, dynamic>.from(e as Map);
        if (map.containsKey('id')) map['id'] = map['id']?.toString();
        return BookModel.fromJson(map);
      }).toList();
    }
    return const <BookModel>[];
  }

  BookModel _mapBook(dynamic data) {
    final map = Map<String, dynamic>.from(data as Map);
    if (map.containsKey('id')) map['id'] = map['id']?.toString();
    return BookModel.fromJson(map);
  }

  Future<List<BookModel>> getAllBooks() async {
    try {
      return await getRequest<List<BookModel>>(
        '/api/Books/GetAll',
        mapper: _mapBooksList,
      );
    } on DioException catch (e) {
      // Debug print for development visibility
      // ignore: avoid_print
      print('getAllBooks error: ${e.response?.statusCode} ${e.message}');
      throw ApiError('Failed to load books', statusCode: e.response?.statusCode);
    }
  }

  Future<BookModel> getBookById(int id) async {
    try {
      return await getRequest<BookModel>(
        '/api/Books/Get/$id',
        mapper: _mapBook,
      );
    } on DioException catch (e) {
      // ignore: avoid_print
      print('getBookById($id) error: ${e.response?.statusCode} ${e.message}');
      throw ApiError('Failed to load book', statusCode: e.response?.statusCode);
    }
  }

  Future<void> createBookForm({
    required String title,
    String? description,
    List<int>? authorIds,
    int? genreId,
    int? bookCategoryId,
    String? bookSKU,
    String? bookUDK,
    DateTime? publishedDate,
    String? filePath,
    String? imagePath,
  }) async {
    try {
      final form = FormData.fromMap({
        'Title': title,
        if (description != null) 'Description': description,
        if (authorIds != null) 'AuthorIds': authorIds,
        if (genreId != null) 'GenreId': genreId,
        if (bookCategoryId != null) 'BookCategoryId': bookCategoryId,
        if (bookSKU != null) 'BookSKU': bookSKU,
        if (bookUDK != null) 'BookUDK': bookUDK,
        if (publishedDate != null) 'PublishedDate': publishedDate.toIso8601String(),
        if (filePath != null) 'File': MultipartFile.fromFileSync(filePath),
        if (imagePath != null) 'ImagePath': MultipartFile.fromFileSync(imagePath),
      });
      await postRequest<void>(
        '/api/Books/Create',
        data: form,
      );
    } on DioException catch (e) {
      // ignore: avoid_print
      print('createBookForm error: ${e.response?.statusCode} ${e.message}');
      throw ApiError('Failed to create book', statusCode: e.response?.statusCode);
    }
  }

  Future<void> updateBookForm({
    required int id,
    String? title,
    String? description,
    List<int>? authorIds,
    int? genreId,
    int? bookCategoryId,
    String? bookSKU,
    String? bookUDK,
    int? offlineBookCount,
    DateTime? publishedDate,
    String? filePath,
    String? imagePath,
  }) async {
    try {
      final form = FormData.fromMap({
        if (title != null) 'Title': title,
        if (description != null) 'Description': description,
        if (authorIds != null) 'AuthorIds': authorIds,
        if (genreId != null) 'GenreId': genreId,
        if (bookCategoryId != null) 'BookCategoryId': bookCategoryId,
        if (bookSKU != null) 'BookSKU': bookSKU,
        if (bookUDK != null) 'BookUDK': bookUDK,
        if (offlineBookCount != null) 'OfflineBookCount': offlineBookCount,
        if (publishedDate != null) 'PublishedDate': publishedDate.toIso8601String(),
        if (filePath != null) 'File': MultipartFile.fromFileSync(filePath),
        if (imagePath != null) 'ImagePath': MultipartFile.fromFileSync(imagePath),
      });
      await putRequest<void>(
        '/api/Books/Update/$id',
        data: form,
      );
    } on DioException catch (e) {
      // ignore: avoid_print
      print('updateBookForm($id) error: ${e.response?.statusCode} ${e.message}');
      throw ApiError('Failed to update book', statusCode: e.response?.statusCode);
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await deleteRequest('/api/Books/Delete/$id');
    } on DioException catch (e) {
      // ignore: avoid_print
      print('deleteBook($id) error: ${e.response?.statusCode} ${e.message}');
      throw ApiError('Failed to delete book', statusCode: e.response?.statusCode);
    }
  }
}


