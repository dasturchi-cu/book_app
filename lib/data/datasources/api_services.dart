import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/data/models/book_model.dart';
import 'package:book_app/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:book_app/core/utils/token_storage.dart';

class BookApiService {
  final Dio _dio = ApiClient.instance;

  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _dio.get('/api/books');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException('Failed to fetch books: ${e.message}');
    }
  }

  Future<BookModel> getBookById(String id) async {
    try {
      final response = await _dio.get('/api/books/$id');
      return BookModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch book: ${e.message}');
    }
  }

  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final response = await _dio.get(
        '/api/books/search',
        queryParameters: {'q': query},
      );
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException('Failed to search books: ${e.message}');
    }
  }
}

class CategoryApiService {
  final Dio _dio = ApiClient.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      // Swagger shows categories under GeneralCategories
      final response = await _dio.get('/api/GeneralCategories');
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
}

class AuthApiService {
  final Dio _dio = ApiClient.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/Users/LogIn',
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
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/api/Users/Create',
        data: {'name': name, 'email': email, 'password': password},
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
      final response = await _dio.get('/api/Users/GetCurrentUser');
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to fetch current user: ${e.message}');
    }
  }

  // Get user by ID
  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      final response = await _dio.get('/api/Users/GetByIdUser/$userId');
      return response.data;
    } on DioException catch (e) {
      throw ApiException('Failed to fetch user: ${e.message}');
    }
  }

  // Get all users (for admin)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await _dio.get('/api/Users/GetAllUsers');
      return List<Map<String, dynamic>>.from(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch users: ${e.message}');
    }
  }
}
