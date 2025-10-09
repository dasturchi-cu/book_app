import 'package:book_app/domain/entities/author.dart';

class AuthorModel {
  final int id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? about;
  final String? country;
  final String? city;
  final String? imagePath;

  const AuthorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.about,
    this.country,
    this.city,
    this.imagePath,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String?,
      about: json['about'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      imagePath: json['imagePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'about': about,
      'country': country,
      'city': city,
      'imagePath': imagePath,
    };
  }

  Author toEntity() {
    return Author(
      id: id.toString(),
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      about: about,
      country: country,
      city: city,
      imagePath: imagePath,
    );
  }

  factory AuthorModel.fromEntity(Author author) {
    return AuthorModel(
      id: int.parse(author.id),
      firstName: author.firstName,
      lastName: author.lastName,
      middleName: author.middleName,
      about: author.about,
      country: author.country,
      city: author.city,
      imagePath: author.imagePath,
    );
  }
}