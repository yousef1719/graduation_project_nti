class ProductModel {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String coverPictureUrl; // استخدم هذا بدلاً من image
  final List<String> productPictures;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;
  final String sellerId;
  final List<String> categories;

  ProductModel({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.coverPictureUrl,
    required this.productPictures,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.sellerId,
    required this.categories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    const baseUrl = 'https://accessories-eshop.runasp.net';

    String getFullUrl(String? url) {
      if (url == null || url.isEmpty) return '';
      if (url.startsWith('http')) return url;
      return '$baseUrl$url';
    }

    return ProductModel(
      id: json['id'] ?? '',
      productCode: json['productCode'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      arabicName: json['arabicName'] ?? '',
      arabicDescription: json['arabicDescription'] ?? '',
      coverPictureUrl: getFullUrl(json['coverPictureUrl']),
      productPictures:
          (json['productPictures'] as List?)
              ?.map((url) => getFullUrl(url))
              .toList() ??
          [],
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
      color: json['color'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0,
      sellerId: json['sellerId'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
    );
  }

  String get image => coverPictureUrl;
}
