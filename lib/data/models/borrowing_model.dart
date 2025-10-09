import 'package:book_app/domain/entities/borrowing.dart';

class BorrowingModel {
  final int id;
  final int userId;
  final int bookId;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnedDate;
  final String? officerOrderCode;
  final bool isReturned;

  const BorrowingModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.dueDate,
    this.returnedDate,
    this.officerOrderCode,
    required this.isReturned,
  });

  factory BorrowingModel.fromJson(Map<String, dynamic> json) {
    return BorrowingModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      bookId: json['bookId'] as int,
      borrowDate: DateTime.parse(json['borrowDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      returnedDate: json['returnedDate'] != null 
          ? DateTime.parse(json['returnedDate'] as String)
          : null,
      officerOrderCode: json['officerOrderCode'] as String?,
      isReturned: json['isReturned'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'borrowDate': borrowDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'returnedDate': returnedDate?.toIso8601String(),
      'officerOrderCode': officerOrderCode,
      'isReturned': isReturned,
    };
  }

  Borrowing toEntity() {
    return Borrowing(
      id: id.toString(),
      userId: userId.toString(),
      bookId: bookId.toString(),
      borrowDate: borrowDate,
      dueDate: dueDate,
      returnedDate: returnedDate,
      officerOrderCode: officerOrderCode,
      isReturned: isReturned,
    );
  }

  factory BorrowingModel.fromEntity(Borrowing borrowing) {
    return BorrowingModel(
      id: int.parse(borrowing.id),
      userId: int.parse(borrowing.userId),
      bookId: int.parse(borrowing.bookId),
      borrowDate: borrowing.borrowDate,
      dueDate: borrowing.dueDate,
      returnedDate: borrowing.returnedDate,
      officerOrderCode: borrowing.officerOrderCode,
      isReturned: borrowing.isReturned,
    );
  }
}