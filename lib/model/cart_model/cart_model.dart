class CartModel {
  final String id;
  final List<CartItem> products;

  CartModel({
    required this.id,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    List<CartItem> cartItems = [];
    for (var item in json['products']) {
      cartItems.add(CartItem.fromJson(item));
    }

    return CartModel(id: json['_id'], products: cartItems);
  }
}

class CartItem {
  final ProductCartModl cartProduct;
  final int quantity;
  final String cartProductId;

  CartItem(
      {required this.cartProduct,
      required this.quantity,
      required this.cartProductId});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        cartProduct: ProductCartModl.fromJson(json['productId']),
        quantity: json['quantity'],
        cartProductId: json['_id']);
  }
}

class ProductCartModl {
  final String productid;
  final String name;
  final String categoryId;
  final ProductImage image;
  final String description;
  final int price;

  ProductCartModl(
      {required this.productid,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.description,
      required this.price});

  factory ProductCartModl.fromJson(Map<String, dynamic> json) {
    return ProductCartModl(
      productid: json['_id'],
      name: json['name'],
      categoryId: json['category'],
      image: ProductImage.fromJson(json['image']),
      description: json['description'],
      price: json['price'],
    );
  }
}

class ProductImage {
  final String imageUrl;
  final String imageId;

  ProductImage({required this.imageUrl, required this.imageId});
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}
