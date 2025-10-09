import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/core/theme/app_theme.dart';
import 'package:book_app/core/network/api_client.dart';
import 'package:book_app/presentation/routes/app_routes.dart';
import 'package:book_app/presentation/pages/login_page.dart';
import 'package:book_app/presentation/pages/home_page.dart';
import 'package:book_app/core/utils/token_storage.dart';
import 'package:book_app/presentation/controllers/category_controller.dart';
import 'package:book_app/presentation/controllers/book_controller.dart';
import 'package:book_app/presentation/controllers/auth_controller.dart';
import 'package:book_app/presentation/controllers/region_controller.dart';
import 'package:book_app/data/repositories/book_repository_impl.dart';
import 'package:book_app/data/repositories/saved_book_repository_impl.dart';
import 'package:book_app/data/repositories/borrowing_repository_impl.dart';
import 'package:book_app/data/repositories/rating_repository_impl.dart';
import 'package:book_app/domain/repositories/book_repository.dart';
import 'package:book_app/domain/repositories/saved_book_repository.dart';
import 'package:book_app/domain/repositories/borrowing_repository.dart';
import 'package:book_app/domain/repositories/rating_repository.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    
    return Obx(() {
      if (authController.isLoggedIn.value) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    });
  }
}

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    _initializeDependencies();

    return GetMaterialApp(
      title: 'IIV MOI Books',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }

  void _initializeDependencies() {
    // Initialize API client
    ApiClient.initialize();

    // Register repositories
    Get.put<BookRepository>(BookRepositoryImpl());
    Get.put<SavedBookRepository>(SavedBookRepositoryImpl());
    Get.put<BorrowingRepository>(BorrowingRepositoryImpl());
    Get.put<RatingRepository>(RatingRepositoryImpl());
    
    // Register auth controller
    Get.put<AuthController>(AuthController());
    
    // Register commonly used controllers once
    Get.put<CategoryController>(CategoryController(), permanent: true);
    Get.put<BookController>(BookController(), permanent: true);
    Get.put<RegionController>(RegionController(), permanent: true);
  }
}
