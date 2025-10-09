import 'package:book_app/domain/entities/genre.dart';

class GenreModel {
  final int id;
  final String name;

  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Genre toEntity() {
    return Genre(
      id: id.toString(),
      name: name,
    );
  }

  factory GenreModel.fromEntity(Genre genre) {
    return GenreModel(
      id: int.parse(genre.id),
      name: genre.name,
    );
  }
}