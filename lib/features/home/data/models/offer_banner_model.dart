class OfferBannerModel {
  final String id;
  final String name;
  final String description;
  final String coverUrl;
  final DateTime createdAt;

  OfferBannerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
  });

  factory OfferBannerModel.fromJson(Map<String, dynamic> json) {
    return OfferBannerModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverUrl: json['coverUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
