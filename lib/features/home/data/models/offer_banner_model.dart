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
    const baseUrl = 'https://accessories-eshop.runasp.net';

    String getFullUrl(String? url) {
      if (url == null || url.isEmpty) {
        return '';
      }
      if (url.startsWith('http')) {
        return url;
      }
      return '$baseUrl$url';
    }

    return OfferBannerModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverUrl: getFullUrl(json['coverUrl']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
