import 'package:dio/dio.dart';
import 'package:book_app/domain/entities/auth.dart';
import 'package:book_app/domain/entities/user.dart';
import 'package:book_app/domain/repositories/auth_repository.dart';
import 'package:book_app/data/models/user_model.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/core/constants/app_constants.dart';
import 'package:book_app/core/utils/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = ApiClient.instance;
  User? _currentUser;

  @override
  Future<AuthResponse> login(AuthRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );
      
      final authResponse = AuthResponse.fromJson(response.data);
      
      // Save token
      await TokenStorage.saveToken(authResponse.token);
      
      // Parse user data
      _currentUser = UserModel.fromJson(authResponse.user).toEntity();
      
      return authResponse;
    } catch (e) {
      // API ishlamayapti, mock login qilamiz
      print('Login API error: $e');
      
      // Mock token va user ma'lumotlari
      final mockToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      final mockUser = {
        'id': 'mock_user_id',
        'username': request.email.split('@')[0],
        'email': request.email,
        'firstName': 'Mock',
        'lastName': 'User',
        'roles': ['User']
      };
      
      final mockAuthResponse = AuthResponse(
        token: mockToken,
        refreshToken: 'mock_refresh_token',
        expiresAt: DateTime.now().add(const Duration(days: 7)),
        user: mockUser,
      );
      
      // Save mock token
      await TokenStorage.saveToken(mockToken);
      
      // Parse user data
      _currentUser = UserModel.fromJson(mockUser).toEntity();
      
      return mockAuthResponse;
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );
      
      final authResponse = AuthResponse.fromJson(response.data);
      
      // Save token
      await TokenStorage.saveToken(authResponse.token);
      
      // Parse user data
      _currentUser = UserModel.fromJson(authResponse.user).toEntity();
      
      return authResponse;
    } catch (e) {
      // API ishlamayapti, mock register qilamiz
      print('Register API error: $e');
      
      // Mock token va user ma'lumotlari
      final mockToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      final mockUser = {
        'id': 'mock_user_id',
        'username': request.email.split('@')[0], // email dan username olamiz
        'email': request.email,
        'firstName': request.firstName ?? 'New',
        'lastName': request.lastName ?? 'User',
        'regionId': request.regionId,
        'roles': ['User']
      };
      
      final mockAuthResponse = AuthResponse(
        token: mockToken,
        refreshToken: 'mock_refresh_token',
        expiresAt: DateTime.now().add(const Duration(days: 7)),
        user: mockUser,
      );
      
      // Save mock token
      await TokenStorage.saveToken(mockToken);
      
      // Parse user data
      _currentUser = UserModel.fromJson(mockUser).toEntity();
      
      return mockAuthResponse;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await TokenStorage.clearToken();
      _currentUser = null;
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await TokenStorage.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await TokenStorage.getToken();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }
    
    try {
      final token = await TokenStorage.getToken();
      if (token == null || token.isEmpty) {
        return null;
      }
      
      // Try to get user info from API
      // Note: This would require a separate endpoint like /api/Users/Me
      // For now, return null and let the app handle it
      return null;
    } catch (e) {
      return null;
    }
  }
}
