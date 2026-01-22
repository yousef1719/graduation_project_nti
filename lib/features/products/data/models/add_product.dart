class AddProduct {
  final String name;
  final String description;
  final String nameArabic;
  final String descriptionArabic;
  final double price;
  final List<String> categories;
  final List<String> productPictures;
  final String coverPictureUrl;
  final String sellerId;
  final String color;

  AddProduct({
    required this.name,
    required this.description,
    required this.nameArabic,
    required this.descriptionArabic,
    required this.price,
    required this.categories,
    required this.productPictures,
    required this.coverPictureUrl,
    required this.sellerId,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "nameArabic": nameArabic,
      "descriptionArabic": descriptionArabic,
      "price": price,
      "categories": categories,
      "productPictures": productPictures,
      "coverPictureUrl": coverPictureUrl,
      "sellerId": sellerId,
      "color": color,
    };
  }
}
