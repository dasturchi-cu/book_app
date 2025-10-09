class Author {
  final String id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? about;
  final String? country;
  final String? city;
  final String? imagePath;

  const Author({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.about,
    this.country,
    this.city,
    this.imagePath,
  });

  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$firstName $middleName $lastName';
    }
    return '$firstName $lastName';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Author && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Author(id: $id, name: $fullName)';
}