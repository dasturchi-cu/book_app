import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_app/domain/entities/book.dart';
import 'package:book_app/presentation/controllers/book_controller.dart';
import 'package:book_app/presentation/routes/app_routes.dart';
import 'package:book_app/core/theme/app_text_styles.dart';
import 'package:book_app/core/theme/app_colors.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          GetBuilder<BookController>(
            builder: (controller) => IconButton(
              onPressed: () => controller.toggleFavorite(book.id),
              icon: Icon(
                book.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: book.isFavorite ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover
            Center(
              child: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: book.coverImageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          book.coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholder(),
                        ),
                      )
                    : _buildPlaceholder(),
              ),
            ),

            const SizedBox(height: 24),

            // Book title
            Text(book.title, style: AppTextStyles.headline3),

            const SizedBox(height: 8),

            // Author
            Text(
              'by ${book.author}',
              style: AppTextStyles.bodyLarge.copyWith(color: Colors.grey[600]),
            ),

            const SizedBox(height: 16),

            // Rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${book.rating} (${book.reviewCount} reviews)',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Categories
            Wrap(
              spacing: 8,
              children: book.categories.map((category) {
                return Chip(
                  label: Text(category),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Description
            if (book.description != null) ...[
              Text('Description', style: AppTextStyles.headline3),
              const SizedBox(height: 8),
              Text(book.description!, style: AppTextStyles.bodyMedium),
              const SizedBox(height: 24),
            ],

            // Book details
            Text('Book Details', style: AppTextStyles.headline3),
            const SizedBox(height: 8),
            _buildDetailRow('Pages', '${book.pageCount}'),
            _buildDetailRow('Language', book.language),
            _buildDetailRow('Published', _formatDate(book.publishedDate)),

            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: book.isAvailable && book.content != null
                        ? () =>
                              Get.toNamed(AppRoutes.bookReader, arguments: book)
                        : null,
                    icon: const Icon(Icons.book),
                    label: const Text('O\'qish'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.find<BookController>().toggleFavorite(book.id);
                    },
                    icon: Icon(
                      book.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: book.isFavorite ? Colors.red : AppColors.primary,
                    ),
                    label: Text(book.isFavorite ? 'Saqlangan' : 'Saqlash'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.book, size: 80, color: Colors.grey),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
