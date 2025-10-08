class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<String> subcategories;
  final bool isInstitute;
  
  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.subcategories,
    this.isInstitute = false,
  });
  
  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    List<String>? subcategories,
    bool? isInstitute,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      subcategories: subcategories ?? this.subcategories,
      isInstitute: isInstitute ?? this.isInstitute,
    );
  }
}
