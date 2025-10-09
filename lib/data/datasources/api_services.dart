import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';
import 'package:book_app/data/models/book_model.dart';
import 'package:book_app/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:book_app/core/utils/token_storage.dart';

class BookApiService {
  final Dio _dio = ApiClient.instance;

  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _dio.get(ApiEndpoints.books);
      final List<dynamic> jsonList = response.data is List ? response.data : <dynamic>[];
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException('Failed to fetch books: ${e.message}');
    }
  }

  Future<BookModel> getBookById(int id) async {
    try {
      final response = await _dio.get(ApiEndpoints.bookById.replaceAll('{id}', id.toString()));
      return BookModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch book: ${e.message}');
    }
  }

  Future<BookModel> createBook({
    required String title,
    required String description,
    required List<int> authorIds,
    required int genreId,
    required int bookCategoryId,
    String? bookSKU,
    String? bookUDK,
    DateTime? publishedDate,
    String? filePath,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'Title': title,
        'Description': description,
        'AuthorIds': authorIds,
        'GenreId': genreId,
        'BookCategoryId': bookCategoryId,
        if (bookSKU != null) 'BookSKU': bookSKU,
        if (bookUDK != null) 'BookUDK': bookUDK,
        if (publishedDate != null) 'PublishedDate': publishedDate.toIso8601String(),
        if (filePath != null) 'File': await MultipartFile.fromFile(filePath),
        if (imagePath != null) 'ImagePath': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.post(ApiEndpoints.createBook, data: formData);
      return BookModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to create book: ${e.message}');
    }
  }

  Future<BookModel> updateBook({
    required int id,
    required String title,
    required String description,
    required List<int> authorIds,
    required int genreId,
    required int bookCategoryId,
    String? bookSKU,
    String? bookUDK,
    int? offlineBookCount,
    DateTime? publishedDate,
    String? filePath,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'Title': title,
        'Description': description,
        'AuthorIds': authorIds,
        'GenreId': genreId,
        'BookCategoryId': bookCategoryId,
        if (bookSKU != null) 'BookSKU': bookSKU,
        if (bookUDK != null) 'BookUDK': bookUDK,
        if (offlineBookCount != null) 'OfflineBookCount': offlineBookCount,
        if (publishedDate != null) 'PublishedDate': publishedDate.toIso8601String(),
        if (filePath != null) 'File': await MultipartFile.fromFile(filePath),
        if (imagePath != null) 'ImagePath': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.put(
        ApiEndpoints.updateBook.replaceAll('{id}', id.toString()),
        data: formData,
      );
      return BookModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to update book: ${e.message}');
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await _dio.delete(ApiEndpoints.deleteBook.replaceAll('{id}', id.toString()));
    } on DioException catch (e) {
      throw ApiException('Failed to delete book: ${e.message}');
    }
  }

  Future<int> getBookCount() async {
    try {
      final response = await _dio.get(ApiEndpoints.getBookCount);
      return response.data as int;
    } on DioException catch (e) {
      throw ApiException('Failed to get book count: ${e.message}');
    }
  }

  Future<int> getTotalBookCount() async {
    try {
      final response = await _dio.get(ApiEndpoints.getBookCountTotal);
      return response.data as int;
    } on DioException catch (e) {
      throw ApiException('Failed to get total book count: ${e.message}');
    }
  }
}

class CategoryApiService {
  final Dio _dio = ApiClient.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      // Swagger shows categories under GeneralCategories
      final response = await _dio.get(ApiEndpoints.generalCategories);
      final List<dynamic> jsonList = response.data is List ? response.data : <dynamic>[];
      // Map minimal fields; backend returns only { name: string }
      return List<CategoryModel>.generate(jsonList.length, (index) {
        final item = Map<String, dynamic>.from(jsonList[index] as Map);
        return CategoryModel(
          id: (item['id']?.toString() ?? '${index + 1}'),
          name: (item['name'] as String?) ?? 'Category',
          description: '',
          icon: '',
          subcategories: const [],
          isInstitute: false,
        );
      });
    } on DioException catch (e) {
      // On 404 or any network error, propagate as ApiException to trigger mock fallback
      throw ApiException('Failed to fetch categories: ${e.message}');
    }
  }

  Future<CategoryModel> getCategoryById(String id) async {
    try {
      // No explicit GET-by-id endpoint in Swagger; fetch all and find
      final all = await getCategories();
      return all.firstWhere((c) => c.id == id);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch category: ${e.message}');
    }
  }

  Future<CategoryModel> createCategory(String name) async {
    try {
      final data = {'name': name};
      final response = await _dio.post(ApiEndpoints.createGeneralCategory, data: data);
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to create category: ${e.message}');
    }
  }

  Future<CategoryModel> updateCategory({
    required int id,
    required String name,
  }) async {
    try {
      final data = {'name': name};
      final response = await _dio.put(
        ApiEndpoints.updateGeneralCategory.replaceAll('{id}', id.toString()),
        data: data,
      );
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to update category: ${e.message}');
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await _dio.delete(ApiEndpoints.deleteGeneralCategory.replaceAll('{id}', id.toString()));
    } on DioException catch (e) {
      throw ApiException('Failed to delete category: ${e.message}');
    }
  }
}

class AuthApiService {
  final Dio _dio = ApiClient.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      // Persist JWT access token if present
      final data = response.data as Map<String, dynamic>;
      final token = data['accessToken'] as String?;
      if (token != null && token.isNotEmpty) {
        await TokenStorage.saveToken(token);
      }
      return data; 
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      throw ApiException('Login failed: ${e.message}', status);
    }
  }

  Future<Map<String, dynamic>> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String regionId,
    String? phoneNumber,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'FirstName': firstName,
          'LastName': lastName,
          'MiddleName': '', // Server talab qilmoqda
          'Email': email,
          'Password': password,
          'PhoneNumber': phoneNumber ?? '',
          'RegionId': regionId,
        },
      );
      return response.data;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      throw ApiException('Registration failed: ${e.message}', status);
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _dio.get('/api/users/profile');
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to fetch user profile: ${e.message}');
    }
  }

  // Get current user info from API
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiEndpoints.getCurrentUser);
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to fetch current user: ${e.message}');
    }
  }

  // Get user by ID
  Future<Map<String, dynamic>> getUserById(int userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getUserById,
        queryParameters: {'id': userId},
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to fetch user: ${e.message}');
    }
  }

  // Get all users (for admin)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllUsers);
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch users: ${e.message}');
    }
  }

  // Get user count
  Future<int> getUserCount() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUserCount);
      return response.data as int;
    } on DioException catch (e) {
      throw ApiException('Failed to get user count: ${e.message}');
    }
  }

  // Get users by region
  Future<int> getUsersByRegion(int regionId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getUsersByRegion.replaceAll('{Id}', regionId.toString()),
      );
      return response.data as int;
    } on DioException catch (e) {
      throw ApiException('Failed to get users by region: ${e.message}');
    }
  }

  // Get non-university users
  Future<List<Map<String, dynamic>>> getNonUniverUsers() async {
    try {
      final response = await _dio.get(ApiEndpoints.getNonUniverUsers);
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch non-university users: ${e.message}');
    }
  }

  // Get university users
  Future<List<Map<String, dynamic>>> getUniverUsers() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUniverUsers);
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch university users: ${e.message}');
    }
  }

  // Update user
  Future<Map<String, dynamic>> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    String? middleName,
    required String email,
    String? phoneNumber,
    String? password,
    required int regionId,
    int? userCategoryId,
    int? userGroupId,
    int? roleId,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        if (middleName != null) 'MiddleName': middleName,
        'Email': email,
        if (phoneNumber != null) 'PhoneNumber': phoneNumber,
        if (password != null) 'Password': password,
        'RegionId': regionId,
        if (userCategoryId != null) 'UserCategoryId': userCategoryId,
        if (userGroupId != null) 'UserGroupId': userGroupId,
        if (roleId != null) 'RoleId': roleId,
        if (imagePath != null) 'ImagePath': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.put(
        ApiEndpoints.updateUser,
        queryParameters: {'id': id},
        data: formData,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to update user: ${e.message}');
    }
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    try {
      await _dio.delete(
        ApiEndpoints.deleteUser,
        queryParameters: {'id': id},
      );
    } on DioException catch (e) {
      throw ApiException('Failed to delete user: ${e.message}');
    }
  }
}
