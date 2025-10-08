import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:book_app/domain/entities/category.dart';
import 'package:book_app/data/models/category_model.dart';
import 'package:book_app/data/datasources/api_services.dart';
import 'package:book_app/core/constants/app_constants.dart';

class CategoryController extends GetxController {
  final CategoryApiService _apiService = CategoryApiService();
  final RxList<Category> categories = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Try API first
      final categoryModels = await _apiService.getCategories();
      categories.value = categoryModels
          .map((model) => model.toEntity())
          .toList();
    } catch (e) {
      // Fallback to mock data
      try {
        final jsonString = await rootBundle.loadString(
          AppConstants.mockCategoriesPath,
        );
        final List<dynamic> jsonList = json.decode(jsonString);

        categories.value = jsonList
            .map<Category>((json) => CategoryModel.fromJson(json).toEntity())
            .toList();
      } catch (mockError) {
        errorMessage.value =
            'Failed to load categories from API and mock data: $e';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Category> get instituteCategories {
    return categories.where((category) => category.isInstitute).toList();
  }

  List<Category> get generalCategories {
    return categories.where((category) => !category.isInstitute).toList();
  }
}
