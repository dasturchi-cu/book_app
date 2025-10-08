class Author {
  final String id;
  final String name;
  final String? biography;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Author({
    required this.id,
    required this.name,
    this.biography,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  Author copyWith({
    String? id,
    String? name,
    String? biography,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Author(
      id: id ?? this.id,
      name: name ?? this.name,
      biography: biography ?? this.biography,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Author && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Author(id: $id, name: $name)';
  }
}
