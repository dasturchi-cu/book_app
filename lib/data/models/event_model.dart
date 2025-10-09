import 'package:book_app/domain/entities/event.dart';

class EventModel {
  final int id;
  final String name;
  final String description;
  final DateTime dateTime;
  final List<String> imagePaths;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.imagePaths,
    this.createdAt,
    this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      imagePaths: (json['imagePaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'imagePaths': imagePaths,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Event toEntity() {
    return Event(
      id: id.toString(),
      name: name,
      description: description,
      dateTime: dateTime,
      imagePaths: imagePaths,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      id: int.parse(event.id),
      name: event.name,
      description: event.description,
      dateTime: event.dateTime,
      imagePaths: event.imagePaths,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );
  }
}