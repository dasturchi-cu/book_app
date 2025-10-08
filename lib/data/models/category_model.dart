import 'package:book_app/domain/entities/category.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<String> subcategories;
  final bool isInstitute;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.subcategories,
    this.isInstitute = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      subcategories: List<String>.from(json['subcategories'] as List),
      isInstitute: json['isInstitute'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'subcategories': subcategories,
      'isInstitute': isInstitute,
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      description: description,
      icon: icon,
      subcategories: subcategories,
      isInstitute: isInstitute,
    );
  }
}
