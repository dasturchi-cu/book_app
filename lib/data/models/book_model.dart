import 'package:book_app/domain/entities/book.dart';

class BookModel {
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
  final String publishedDate;
  final String language;
  final bool isFavorite;
  final bool isAvailable;

  const BookModel({
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    try {
      // API dan kelayotgan ma'lumotlar bilan moslashtirish
      final authors = json['authors'] as List<dynamic>? ?? [];
      final authorName = authors.isNotEmpty 
          ? '${authors.first['firstName']} ${authors.first['lastName']}'
          : 'Unknown Author';
      
      final ratings = json['ratings'] as List<dynamic>? ?? [];
      final averageRating = ratings.isNotEmpty 
          ? (ratings.first['rating'] as num).toDouble()
          : 0.0;
      
      return BookModel(
        id: json['id'].toString(), // API dan raqamli keladi
        title: json['title'] as String,
        author: authorName,
        description: json['description'] as String?,
        coverImageUrl: json['imagePath'] as String?, // API da imagePath
        categories: [json['genreName'] as String? ?? 'Unknown'], // API da genreName
        rating: averageRating,
        reviewCount: ratings.length,
        content: json['filePath'] as String?, // API da filePath
        pageCount: 0, // API da yo'q, default qiymat
        publishedDate: json['publishedDate'] as String? ?? '',
        language: 'Uzbek', // Default qiymat
        isFavorite: false, // Default qiymat
        isAvailable: json['borrowedBookCount'] == null, // borrowedBookCount null bo'lsa mavjud
      );
    } catch (e) {
      print('Error parsing book: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'categories': categories,
      'rating': rating,
      'reviewCount': reviewCount,
      'content': content,
      'pageCount': pageCount,
      'publishedDate': publishedDate,
      'language': language,
      'isFavorite': isFavorite,
      'isAvailable': isAvailable,
    };
  }

  Book toEntity() {
    return Book(
      id: id,
      title: title,
      author: author,
      description: description,
      coverImageUrl: coverImageUrl,
      categories: categories,
      rating: rating,
      reviewCount: reviewCount,
      content: content,
      pageCount: pageCount,
      publishedDate: DateTime.parse(publishedDate),
      language: language,
      isFavorite: isFavorite,
      isAvailable: isAvailable,
    );
  }

  factory BookModel.fromEntity(Book book) {
    return BookModel(
      id: book.id,
      title: book.title,
      author: book.author,
      description: book.description,
      coverImageUrl: book.coverImageUrl,
      categories: book.categories,
      rating: book.rating,
      reviewCount: book.reviewCount,
      content: book.content,
      pageCount: book.pageCount,
      publishedDate: book.publishedDate.toIso8601String(),
      language: book.language,
      isFavorite: book.isFavorite,
      isAvailable: book.isAvailable,
    );
  }
}
