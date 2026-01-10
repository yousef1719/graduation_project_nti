class CategoryModel {
  final String? id;
  final String name;
  final String? description;
  final String image;

  CategoryModel({
    this.id,
    this.description,
    required this.name,
    required this.image,
  });

  // factory CategoryModel.fromJson(Map<String, dynamic> json) {
  //   return CategoryModel(
  //     id: json['id'] ?? '',
  //     name: json['name'] ?? '',
  //     description: json['description'] ?? '',
  //     image: json['coverPictureUrl'] ?? '',
  //   );
  // }
}
