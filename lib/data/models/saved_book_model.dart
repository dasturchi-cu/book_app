import 'package:book_app/domain/entities/saved_book.dart';

class SavedBookModel {
  final String id;
  final String bookId;
  final String userId;
  final DateTime savedAt;

  const SavedBookModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.savedAt,
  });

  factory SavedBookModel.fromJson(Map<String, dynamic> json) {
    return SavedBookModel(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  SavedBook toEntity() {
    return SavedBook(
      id: id,
      bookId: bookId,
      userId: userId,
      savedAt: savedAt,
    );
  }

  factory SavedBookModel.fromEntity(SavedBook savedBook) {
    return SavedBookModel(
      id: savedBook.id,
      bookId: savedBook.bookId,
      userId: savedBook.userId,
      savedAt: savedBook.savedAt,
    );
  }
}
