class Book {
  final String id;
  final String title;
  final String author;
  final String? description;
  final String? coverImageUrl;
  final List<String> categories;
  final double rating;
  final int reviewCount;
  final String? content;
  final int pageCount;
  final DateTime publishedDate;
  final String language;
  final bool isFavorite;
  final bool isAvailable;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.description,
    this.coverImageUrl,
    required this.categories,
    required this.rating,
    required this.reviewCount,
    this.content,
    required this.pageCount,
    required this.publishedDate,
    required this.language,
    this.isFavorite = false,
    this.isAvailable = true,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImageUrl,
    List<String>? categories,
    double? rating,
    int? reviewCount,
    String? content,
    int? pageCount,
    DateTime? publishedDate,
    String? language,
    bool? isFavorite,
    bool? isAvailable,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      content: content ?? this.content,
      pageCount: pageCount ?? this.pageCount,
      publishedDate: publishedDate ?? this.publishedDate,
      language: language ?? this.language,
      isFavorite: isFavorite ?? this.isFavorite,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Book && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author)';
  }
}
