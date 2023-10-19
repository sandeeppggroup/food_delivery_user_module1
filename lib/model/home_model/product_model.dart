class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final bool isBlocked;
  final ProductImage image;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.isBlocked,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'].toDouble(),
      isBlocked: json['isBlocked'],
      image: ProductImage.fromJson(json['image']),
    );
  }
}

class ProductImage {
  final String imageUrl;
  final String imageId;

  ProductImage({
    required this.imageUrl,
    required this.imageId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}
