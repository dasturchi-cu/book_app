class Rating {
  final String id;
  final String bookId;
  final String userId;
  final double rating;
  final String? review;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Rating({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rating,
    this.review,
    required this.createdAt,
    this.updatedAt,
  });

  Rating copyWith({
    String? id,
    String? bookId,
    String? userId,
    double? rating,
    String? review,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Rating(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rating && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Rating(id: $id, bookId: $bookId, rating: $rating)';
  }
}
