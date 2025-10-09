class Genre {
  final String id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Genre && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}