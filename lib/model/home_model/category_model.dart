class CategoryModel {
  final String id;
  final String name;
  final bool isBlocked;
  final CategoryImage image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.isBlocked,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      isBlocked: json['isBlocked'],
      image: CategoryImage.fromJson(json['image']),
    );
  }
}

class CategoryImage {
  final String publicId;
  final String imageUrl;

  CategoryImage({
    required this.publicId,
    required this.imageUrl,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      publicId: json['public_id'],
      imageUrl: json['image'],
    );
  }
}
