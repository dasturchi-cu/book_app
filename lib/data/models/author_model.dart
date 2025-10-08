import 'package:book_app/domain/entities/author.dart';

class AuthorModel {
  final String id;
  final String name;
  final String? biography;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AuthorModel({
    required this.id,
    required this.name,
    this.biography,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      biography: json['biography'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'biography': biography,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Author toEntity() {
    return Author(
      id: id,
      name: name,
      biography: biography,
      profileImageUrl: profileImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AuthorModel.fromEntity(Author author) {
    return AuthorModel(
      id: author.id,
      name: author.name,
      biography: author.biography,
      profileImageUrl: author.profileImageUrl,
      createdAt: author.createdAt,
      updatedAt: author.updatedAt,
    );
  }
}
