import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/presentation/controllers/book_controller.dart';
import 'package:book_app/presentation/controllers/category_controller.dart';
import 'package:book_app/presentation/controllers/auth_controller.dart';
import 'package:book_app/presentation/widgets/category_card.dart';
import 'package:book_app/presentation/widgets/book_card.dart';
import 'package:book_app/presentation/widgets/bottom_navigation_widget.dart';
import 'package:book_app/presentation/widgets/app_drawer.dart';
import 'package:book_app/presentation/routes/app_routes.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) => Scaffold(
        backgroundColor: AppColors.surface,
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              // Header with Menu Button and IIV MOI Logo
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Hamburger Menu Button
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                    ),
                    // Logo
                    Expanded(
                      child: Center(
                        child: Text(
                          'IIV MOI',
                          style: AppTextStyles.headline1.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    // Placeholder for symmetry
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Role-based Pages Section
                      _buildUserRolePages(),
                      const SizedBox(height: 24),
                      
                      // Main Categories Section
                      Obx(() {
                        if (categoryController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if (categoryController.errorMessage.value.isNotEmpty) {
                          return Center(
                            child: Text(
                              categoryController.errorMessage.value,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Institute Literature
                            if (categoryController
                                .instituteCategories
                                .isNotEmpty) ...[
                              Text(
                                'Institut adabiyotlari',
                                style: AppTextStyles.headline3.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryController
                                      .instituteCategories
                                      .length,
                                  itemBuilder: (context, index) {
                                    final category = categoryController
                                        .instituteCategories[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SizedBox(
                                        width: 280,
                                        child: CategoryCard(
                                          category: category,
                                          onTap: () =>
                                              _navigateToCategory(category),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],

                            // General Literature
                            if (categoryController
                                .generalCategories
                                .isNotEmpty) ...[
                              Text(
                                'Umumiy adabiyotlar',
                                style: AppTextStyles.headline3.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryController
                                      .generalCategories
                                      .length,
                                  itemBuilder: (context, index) {
                                    final category = categoryController
                                        .generalCategories[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: SizedBox(
                                        width: 280,
                                        child: CategoryCard(
                                          category: category,
                                          onTap: () =>
                                              _navigateToCategory(category),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ],
                        );
                      }),

                      // Recommended Books Section
                      Text(
                        'Tavsiya etilgan kitoblar',
                        style: AppTextStyles.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Recommended Books Grid
                      GetBuilder<BookController>(
                        builder: (bookController) => Obx(() {
                          if (bookController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          }

                          if (bookController.books.isEmpty) {
                            return const Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.book_outlined,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text('Kitoblar topilmadi'),
                                ],
                              ),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemCount: bookController.books.take(4).length,
                            itemBuilder: (context, index) {
                              final book = bookController.books[index];
                              return BookCard(
                                book: book,
                                onTap: () => Get.toNamed(
                                  AppRoutes.bookDetails,
                                  arguments: book,
                                ),
                                onFavorite: () =>
                                    bookController.toggleFavorite(book.id),
                              );
                            },
                          );
                        }),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationWidget(currentIndex: 0),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.apiTest),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.api, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildUserRolePages() {
    return GetBuilder<AuthController>(
      builder: (authController) => Obx(() {
        final isInstituteEmployee = authController.isInstituteEmployee;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sahifalar',
              style: AppTextStyles.headline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Books page - visible to all users
            _buildPageCard(
              'Kitoblar',
              'Barcha kitoblar va adabiyotlar',
              Icons.menu_book,
              AppColors.primary,
              () => Get.snackbar('Kitoblar', 'Kitoblar sahifasi'),
            ),
            
            const SizedBox(height: 12),
            
            // Institute employee only pages
            if (isInstituteEmployee) ...[
              _buildPageCard(
                'Video Darslar',
                'Institut xodimlari uchun video darslar',
                Icons.video_library,
                Colors.red,
                () => Get.toNamed(AppRoutes.videoLessons),
              ),
              const SizedBox(height: 12),
              
              _buildPageCard(
                'Talablar',
                'Institut talablari va qoidalar',
                Icons.rule,
                Colors.orange,
                () => Get.toNamed(AppRoutes.requirements),
              ),
              const SizedBox(height: 12),
              
              _buildPageCard(
                'Darsliklar',
                'Institut darsliklari va qo\'llanmalar',
                Icons.school,
                Colors.green,
                () => Get.toNamed(AppRoutes.textbooks),
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _buildPageCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.onSurface.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCategory(category) {
    // TODO: Navigate to category details page
    Get.snackbar(
      'Kategoriya',
      '${category.name} kategoriyasi ochilmoqda...',
      backgroundColor: AppColors.primary.withOpacity(0.1),
      colorText: AppColors.onSurface,
    );
  }
}
