class Borrowing {
  final String id;
  final String userId;
  final String bookId;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnedDate;
  final String? officerOrderCode;
  final bool isReturned;

  const Borrowing({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.dueDate,
    this.returnedDate,
    this.officerOrderCode,
    required this.isReturned,
  });

  bool get isOverdue {
    if (isReturned) return false;
    return DateTime.now().isAfter(dueDate);
  }

  int get daysOverdue {
    if (!isOverdue) return 0;
    return DateTime.now().difference(dueDate).inDays;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Borrowing && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Borrowing(id: $id, bookId: $bookId, userId: $userId)';
}