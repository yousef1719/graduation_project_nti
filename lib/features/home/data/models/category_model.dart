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

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // 1. استلام القيمة من السيرفر
    String rawImage = json['coverPictureUrl'] ?? '';

    String finalImageUrl = '';

    // 2. الفحص الذكي: هل القيمة هي "string" أو فارغة؟
    if (rawImage.isEmpty || rawImage.toLowerCase() == 'string') {
      finalImageUrl = ""; // نتركها فارغة والـ UI سيعرض أيقونة بديلة
    }
    // 3. إذا كان الرابط كاملاً يبدأ بـ http
    else if (rawImage.startsWith('http')) {
      finalImageUrl = rawImage;
    }
    // 4. إذا كان مساراً ناقصاً (مثل /uploads/img.jpg)
    else {
      // نضمن وجود / واحدة فقط بين الدومين والمسار
      String cleanPath = rawImage.startsWith('/')
          ? rawImage.substring(1)
          : rawImage;
      finalImageUrl = "https://accessories-eshop.runasp.net/$cleanPath";
    }

    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: finalImageUrl,
    );
  }
}
