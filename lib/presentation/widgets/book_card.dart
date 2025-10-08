import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_app/domain/entities/book.dart';
import 'package:book_app/core/theme/app_text_styles.dart';
import 'package:book_app/presentation/widgets/rating_widget.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const BookCard({super.key, required this.book, this.onTap, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover placeholder
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: book.coverImageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: book.coverImageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => _buildPlaceholder(),
                          ),
                        )
                      : _buildPlaceholder(),
                ),
              ),

              const SizedBox(height: 8),

              // Book title
              Expanded(
                flex: 2,
                child: Text(
                  book.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4),

              // Author
              Text(
                book.author,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // Rating and favorite button
              Row(
                children: [
                  Expanded(
                    child: RatingWidget(
                      rating: book.rating,
                      reviewCount: book.reviewCount,
                      starSize: 14.0,
                      showReviewCount: false,
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      book.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: book.isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.book, size: 40, color: Colors.grey),
    );
  }
}
