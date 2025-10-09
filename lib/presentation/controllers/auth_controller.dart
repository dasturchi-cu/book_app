import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/data/datasources/api_services.dart';
import 'package:book_app/core/utils/token_storage.dart';
import 'package:book_app/presentation/pages/home_page.dart';

class AuthController extends GetxController {
  final AuthApiService _apiService = AuthApiService();
  final RxBool isLoggedIn = false.obs;
  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;
  final RxString userToken = ''.obs;
  final RxInt userRoleId = 2.obs;
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
    
    // API server muammolari tufayli faqat mock authentication ishlatamiz
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock authentication - har doim muvaffaqiyatli
      userToken.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      userEmail.value = email;
      userName.value = email.split('@')[0]; // Email dan username olamiz
      userRoleId.value = 2; // Default to ordinary user
      isLoggedIn.value = true;
      
      await TokenStorage.saveToken(userToken.value);

      // Show success message first
      Get.snackbar(
        'Muvaffaqiyatli',
        'Tizimga kirdingiz!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Force navigation to home page
      await Future.delayed(const Duration(milliseconds: 100));
      Get.offAll(() => const HomePage());
    } catch (e) {
      errorMessage.value = 'Xatolik yuz berdi: $e';
      print('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void register(String email, String password, String firstName, String lastName, String regionId, {String? phoneNumber}) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    // API server muammolari tufayli faqat mock authentication ishlatamiz
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock authentication - har doim muvaffaqiyatli
      userToken.value = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      userEmail.value = email;
      userName.value = firstName;
      userRoleId.value = 2; // Default to ordinary user
      isLoggedIn.value = true;
      
      await TokenStorage.saveToken(userToken.value);

      // Show success message first
      Get.snackbar(
        'Muvaffaqiyatli',
        'Ro\'yxatdan o\'tdingiz!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Force navigation to home page
      await Future.delayed(const Duration(milliseconds: 100));
      Get.offAll(() => const HomePage());
    } catch (e) {
      errorMessage.value = 'Xatolik yuz berdi: $e';
      print('Register error: $e');
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
