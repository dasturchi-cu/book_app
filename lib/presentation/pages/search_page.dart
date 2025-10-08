import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/presentation/controllers/book_controller.dart';
import 'package:book_app/presentation/widgets/book_card.dart';
import 'package:book_app/presentation/routes/app_routes.dart';
import 'package:book_app/core/theme/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text('Qidiruv'),
        foregroundColor: AppColors.onSurface,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Kitob nomi, muallif yoki kalit so\'z...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.background,
              ),
              onChanged: (query) {
                Get.find<BookController>().searchBooks(query);
              },
            ),
          ),

          // Filters
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Barchasi', true),
                const SizedBox(width: 8),
                _buildFilterChip('Reyting', false),
                const SizedBox(width: 8),
                _buildFilterChip('Mashhur', false),
                const SizedBox(width: 8),
                _buildFilterChip('Yangi', false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Search Results
          Expanded(
            child: GetBuilder<BookController>(
              builder: (controller) => Obx(() {
                if (controller.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (controller.filteredBooks.isEmpty &&
                    controller.searchQuery.value.isNotEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Kitoblar topilmadi'),
                        SizedBox(height: 8),
                        Text('Boshqa kalit so\'zlar bilan qidiring'),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = controller.filteredBooks[index];
                    return BookCard(
                      book: book,
                      onTap: () =>
                          Get.toNamed(AppRoutes.bookDetails, arguments: book),
                      onFavorite: () => controller.toggleFavorite(book.id),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Implement filter logic
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.grey[600],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
