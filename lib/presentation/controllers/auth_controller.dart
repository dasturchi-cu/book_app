import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/data/datasources/api_services.dart';
import 'package:book_app/core/utils/token_storage.dart';

class AuthController extends GetxController {
  final AuthApiService _apiService = AuthApiService();
  final RxBool isLoggedIn = false.obs;
  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;
  final RxString userToken = ''.obs;
  final RxInt userRoleId = 2.obs; // Default to ordinary user (2), institute employees (1)
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  // Load user data from API after login
  Future<void> _loadUserData() async {
    if (isLoggedIn.value && userToken.value.isNotEmpty) {
      try {
        final userData = await _apiService.getCurrentUser();
        _updateUserFromApi(userData);
      } catch (e) {
        print('Failed to load user data from API: $e');
        // Continue with existing data if API fails
      }
    }
  }

  // Update user data from API response
  void _updateUserFromApi(Map<String, dynamic> userData) {
    userName.value = userData['name'] ?? userData['fullName'] ?? userName.value;
    userEmail.value = userData['email'] ?? userEmail.value;
    
    // Extract role ID from API response
    final roleId = userData['roleId'] ?? userData['role'] ?? userData['id'] ?? 2;
    userRoleId.value = roleId is int ? roleId : 2;
  }
  void login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      final response = await _apiService.login(email, password);

      // Store user data
      final token = response['accessToken'] ?? response['token'] ?? response['data']?['token'] ?? '';
      if (token is String && token.isNotEmpty) {
        userToken.value = token;
        await TokenStorage.saveToken(token);
      }
      userEmail.value = email;
      userName.value = response['user']?['name'] ?? '';
      
      // Extract user role ID from response
      final roleId = response['user']?['roleId'] ?? response['roleId'] ?? response['user']?['id'] ?? 2;
      userRoleId.value = roleId is int ? roleId : 2;
      
      isLoggedIn.value = true;

      // Load additional user data from API
      await _loadUserData();

      Get.offAllNamed('/');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Login failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void register(String email, String password, String firstName, String lastName, {String? phoneNumber}) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      final response = await _apiService.register(firstName, email, password);

      // Store user data
      userToken.value = response['token'] ?? '';
      userEmail.value = email;
      userName.value = firstName;
      
      // Extract user role ID from response
      final roleId = response['user']?['roleId'] ?? response['roleId'] ?? response['user']?['id'] ?? 2;
      userRoleId.value = roleId is int ? roleId : 2;
      
      isLoggedIn.value = true;

      Get.offAllNamed('/');
    } catch (e) {
      errorMessage.value = e.toString();
      // If API registration fails, use mock authentication for development
      print('API registration failed, using mock authentication: $e');

      // Mock successful registration for development
      userToken.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      userEmail.value = email;
      userName.value = firstName;
      userRoleId.value = 2; // Default to ordinary user for mock
      isLoggedIn.value = true;

      Get.offAllNamed('/');

      // Show info message
      Get.snackbar(
        'Development Mode',
        'Using mock authentication. API registration not available.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    userEmail.value = '';
    userName.value = '';
    userToken.value = '';
    userRoleId.value = 2; // Reset to default
    errorMessage.value = '';
    TokenStorage.clearToken();
    Get.offAllNamed('/login');
  }

  void clearError() {
    errorMessage.value = '';
  }

  bool get isAuthenticated => isLoggedIn.value;
  
  // User role helpers
  bool get isInstituteEmployee => userRoleId.value == 1;
  bool get isOrdinaryUser => userRoleId.value == 2;
  String get userRoleName => isInstituteEmployee ? 'Institut xodimlari' : 'Oddiy foydalanuvchi';
  
  Map<String, dynamic>? get currentUser => isLoggedIn.value ? {
    'email': userEmail.value,
    'name': userName.value,
    'fullName': userName.value,
    'token': userToken.value,
    'roleId': userRoleId.value,
    'roleName': userRoleName,
  } : null;
}
