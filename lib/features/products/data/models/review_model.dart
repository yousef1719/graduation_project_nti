class ReviewModel {
  final String comment;
  final int rating;
  final String createdAt;
  final String userName;
  final String? userPicture;

  ReviewModel({
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userName,
    this.userPicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      userName: json['userName'] ?? '',
      userPicture: json['userPicture'],
    );
  }
}
