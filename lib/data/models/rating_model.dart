import 'package:book_app/domain/entities/rating.dart';

class RatingModel {
  final String id;
  final String bookId;
  final String userId;
  final double rating;
  final String? review;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const RatingModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rating,
    this.review,
    required this.createdAt,
    this.updatedAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Rating toEntity() {
    return Rating(
      id: id,
      bookId: bookId,
      userId: userId,
      rating: rating,
      review: review,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory RatingModel.fromEntity(Rating rating) {
    return RatingModel(
      id: rating.id,
      bookId: rating.bookId,
      userId: rating.userId,
      rating: rating.rating,
      review: rating.review,
      createdAt: rating.createdAt,
      updatedAt: rating.updatedAt,
    );
  }
}
