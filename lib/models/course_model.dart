class CourseModel {
  final int? id;
  final String name;
  final String category;
  final String duration;
  final String fee;
  final String description;
  final String? image;

  CourseModel({
    this.id,
    required this.name,
    required this.category,
    required this.duration,
    required this.fee,
    required this.description,
    this.image,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      category: json['category_name'] ?? json['category'],
      duration: json['duration'],
      fee: json['fee'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': _getCategoryId(category),
      'duration': duration,
      'fee': fee,
      'description': description,
    };
  }

  int _getCategoryId(String category) {
    const categories = {
      'Engineering': 1,
      'Medical': 2,
      'Law': 3,
      'Teaching': 4,
      'Business': 5,
      'Arts': 6,
      'Technology': 7,
      'Science': 8,
    };
    return categories[category] ?? 1;
  }
}