import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:book_app/core/theme/app_colors.dart';
import 'package:book_app/core/theme/app_text_styles.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool showReviewCount;
  final bool allowRating;
  final Function(double)? onRatingChanged;
  final double starSize;
  final bool readOnly;

  const RatingWidget({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.showReviewCount = true,
    this.allowRating = false,
    this.onRatingChanged,
    this.starSize = 20.0,
    this.readOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: starSize,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: readOnly ? (rating) {} : (rating) {
            if (onRatingChanged != null) {
              onRatingChanged!(rating);
            }
          },
          ignoreGestures: readOnly,
        ),
        if (showReviewCount && reviewCount > 0) ...[
          const SizedBox(width: 8),
          Text(
            '($reviewCount)',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }
}

class RatingInputWidget extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;
  final String? label;
  final bool showLabel;

  const RatingInputWidget({
    super.key,
    this.initialRating = 0.0,
    required this.onRatingChanged,
    this.label,
    this.showLabel = true,
  });

  @override
  State<RatingInputWidget> createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
                widget.onRatingChanged(rating);
              },
            ),
            const SizedBox(width: 12),
            Text(
              _getRatingText(_currentRating),
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getRatingText(double rating) {
    if (rating == 0) return 'Not rated';
    if (rating <= 1) return 'Poor';
    if (rating <= 2) return 'Fair';
    if (rating <= 3) return 'Good';
    if (rating <= 4) return 'Very Good';
    return 'Excellent';
  }
}

class ReviewWidget extends StatelessWidget {
  final String author;
  final double rating;
  final String review;
  final DateTime date;
  final bool showDate;

  const ReviewWidget({
    super.key,
    required this.author,
    required this.rating,
    required this.review,
    required this.date,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    author,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RatingWidget(
                  rating: rating,
                  starSize: 16.0,
                  showReviewCount: false,
                  readOnly: true,
                ),
              ],
            ),
            if (showDate) ...[
              const SizedBox(height: 4),
              Text(
                _formatDate(date),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              review,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
