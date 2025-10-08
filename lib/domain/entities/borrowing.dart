class Borrowing {
  final String id;
  final String bookId;
  final String userId;
  final DateTime borrowedAt;
  final DateTime? returnedAt;
  final DateTime dueDate;
  final bool isReturned;

  const Borrowing({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.borrowedAt,
    this.returnedAt,
    required this.dueDate,
    required this.isReturned,
  });

  Borrowing copyWith({
    String? id,
    String? bookId,
    String? userId,
    DateTime? borrowedAt,
    DateTime? returnedAt,
    DateTime? dueDate,
    bool? isReturned,
  }) {
    return Borrowing(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      userId: userId ?? this.userId,
      borrowedAt: borrowedAt ?? this.borrowedAt,
      returnedAt: returnedAt ?? this.returnedAt,
      dueDate: dueDate ?? this.dueDate,
      isReturned: isReturned ?? this.isReturned,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Borrowing && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Borrowing(id: $id, bookId: $bookId, isReturned: $isReturned)';
  }
}
