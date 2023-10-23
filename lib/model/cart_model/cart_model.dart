class Cart {
  final String id;
  final List<CartItem> products;

  Cart({
    required this.id,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> cartItems = [];
    for (var item in json['products']) {
      cartItems.add(CartItem.fromJson(item));
    }

    return Cart(id: json['_id'], products: cartItems);
  }
}

class CartItem {
  final Product cartProduct;
  final int quantity;
  final String cartProductId;

  CartItem(
      {required this.cartProduct,
      required this.quantity,
      required this.cartProductId});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        cartProduct: Product.fromJson(json['productId']),
        quantity: json['quantity'],
        cartProductId: json['_id']);
  }
}

class Product {
  final String productid;
  final String name;
  final String categoryId;
  final ProductImage image;
  final String description;
  final int price;

  Product(
      {required this.productid,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.description,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
