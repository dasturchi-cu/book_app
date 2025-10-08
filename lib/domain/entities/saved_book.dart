class SavedBook {
  final String id;
  final String bookId;
  final String userId;
  final DateTime savedAt;

  const SavedBook({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.savedAt,
  });

  SavedBook copyWith({
    String? id,
    String? bookId,
    String? userId,
    DateTime? savedAt,
  }) {
    return SavedBook(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      userId: userId ?? this.userId,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SavedBook && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SavedBook(id: $id, bookId: $bookId, userId: $userId)';
  }
}
