class Event {
  final String id;
  final String name;
  final String description;
  final DateTime dateTime;
  final List<String> imagePaths;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.imagePaths,
    this.createdAt,
    this.updatedAt,
  });

  bool get isUpcoming => DateTime.now().isBefore(dateTime);
  bool get isPast => DateTime.now().isAfter(dateTime);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Event(id: $id, name: $name, date: $dateTime)';
}