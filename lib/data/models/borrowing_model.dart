import 'package:book_app/domain/entities/borrowing.dart';

class BorrowingModel {
  final String id;
  final String bookId;
  final String userId;
  final DateTime borrowedAt;
  final DateTime? returnedAt;
  final DateTime dueDate;
  final bool isReturned;

  const BorrowingModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.borrowedAt,
    this.returnedAt,
    required this.dueDate,
    required this.isReturned,
  });

  factory BorrowingModel.fromJson(Map<String, dynamic> json) {
    return BorrowingModel(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      userId: json['userId'] as String,
      borrowedAt: DateTime.parse(json['borrowedAt'] as String),
      returnedAt: json['returnedAt'] != null 
          ? DateTime.parse(json['returnedAt'] as String) 
          : null,
      dueDate: DateTime.parse(json['dueDate'] as String),
      isReturned: json['isReturned'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'borrowedAt': borrowedAt.toIso8601String(),
      'returnedAt': returnedAt?.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'isReturned': isReturned,
    };
  }

  Borrowing toEntity() {
    return Borrowing(
      id: id,
      bookId: bookId,
      userId: userId,
      borrowedAt: borrowedAt,
      returnedAt: returnedAt,
      dueDate: dueDate,
      isReturned: isReturned,
    );
  }

  factory BorrowingModel.fromEntity(Borrowing borrowing) {
    return BorrowingModel(
      id: borrowing.id,
      bookId: borrowing.bookId,
      userId: borrowing.userId,
      borrowedAt: borrowing.borrowedAt,
      returnedAt: borrowing.returnedAt,
      dueDate: borrowing.dueDate,
      isReturned: borrowing.isReturned,
    );
  }
}
